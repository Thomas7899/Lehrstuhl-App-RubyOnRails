require "openai"

class ChatbotService
  DAILY_REQUEST_LIMIT = (ENV["DAILY_LIMIT"]&.to_i || 50).freeze
  MAX_TOKENS_DEFAULT  = (ENV["OPENAI_MAX_TOKENS"]&.to_i || 400).freeze
  DEFAULT_MODEL       = ENV["OPENAI_CHAT_MODEL"] || "gpt-4o-mini"
  ROUTER_MODEL        = ENV["OPENAI_ROUTER_MODEL"] || "gpt-4o-mini" 

  def initialize
    @openai_key = ENV["OPENAI_API_KEY"]
    unless @openai_key&.start_with?("sk-")
      raise "OpenAI API-Key fehlt oder ist ungültig. Bitte setze ENV['OPENAI_API_KEY']"
    end

    @client = OpenAI::Client.new(access_token: @openai_key)
  end

  def generate_response(message, user)
    if over_daily_limit?(user)
      return "(Tageslimit erreicht – bitte morgen erneut versuchen.)"
    end

    intent_data = determine_user_intent(message)
    intent_type = intent_data[:type]
    intent_query = intent_data[:query]

    context = gather_relevant_context(intent_query, intent_type)
    system_prompt = build_system_prompt(intent_type)
    
    conversation = build_conversation_history(user, message)

    response = @client.chat(
      parameters: {
        model: DEFAULT_MODEL,
        messages: [
          { role: "system", content: system_prompt },
          { role: "system", content: "KONTEXT:\n#{context}" },
          *conversation
        ],
        max_tokens: MAX_TOKENS_DEFAULT,
        temperature: 0.7
      }
    )

    text = response.dig("choices", 0, "message", "content")
    increment_user_usage(user)

    text || "(Leere Antwort von OpenAI erhalten.)"
  rescue => e
    Rails.logger.error "[Chatbot] Fehler: #{e.message}"
    "(KI-Fehler: #{e.message})"
  end

  private

  def determine_user_intent(message)
    tools = [
      {
        type: "function",
        function: {
          name: "get_context_for_query",
          description: "Ruft relevante Informationen aus der Lehrstuhl-Datenbank ab.",
          parameters: {
            type: "object",
            properties: {
              intent: {
                type: "string",
                description: "Der Typ der Information, nach der gesucht wird.",
                enum: ["abschlussarbeit", "seminar", "klausur", "faq", "allgemein"]
              },
              search_query: {
                type: "string",
                description: "Optimierte semantische Suchanfrage (z.B. nur die Keywords oder die Kernfrage)"
              }
            },
            required: ["intent", "search_query"]
          }
        }
      }
    ]

    response = @client.chat(
      parameters: {
        model: ROUTER_MODEL,
        messages: [{ role: "user", content: message }],
        tools: tools,
        tool_choice: { type: "function", function: { name: "get_context_for_query" } }
      }
    )

    tool_call = response.dig("choices", 0, "message", "tool_calls", 0, "function")
    if tool_call
      args = JSON.parse(tool_call["arguments"], symbolize_names: true)
      return { type: args[:intent], query: args[:search_query] }
    else
      return { type: "allgemein", query: message }
    end

  rescue => e
    Rails.logger.error "[Chatbot Router] Fehler: #{e.message}"
    return { type: "allgemein", query: message }
  end

  def build_system_prompt(intent)
    intent_hint = case intent
                  when "faq"
                    "Beantworte die Frage des Nutzers präzise mithilfe der folgenden FAQ-Einträge."
                  when "klausur"
                    "Liefere Informationen zu Klausuren basierend auf den folgenden Daten."
                  when "seminar"
                    "Liefere Informationen zu Seminaren basierend auf den folgenden Daten."
                  when "abschlussarbeit"
                    "Liefere Informationen zu Abschlussarbeiten basierend auf den folgenden Daten."
                  else
                    "Beantworte die Frage des Nutzers."
                  end

    <<~PROMPT
      Du bist ein deutschsprachiger Lehrstuhl-Assistent.
      #{intent_hint}
      Beantworte Fragen sachlich, prägnant und basiere deine Antwort NUR auf den bereitgestellten KONTEXT-Informationen.
      Wenn der Kontext keine Antwort auf die Frage enthält, sage, dass du dazu keine Informationen hast.
      Erfinde keine Informationen.
    PROMPT
  end

  def gather_relevant_context(query, intent)
    RagContextService.new.gather_targeted_context(query: query, intent: intent)
  rescue => e
    Rails.logger.error "[RAG] Fehler beim Laden des Kontexts: #{e.message}"
    "Fehler beim Laden des Kontexts."
  end

  def build_conversation_history(user, current_message)
    recent = ChatMessage.conversation_history(user).last(5)
    recent.map { |m| { role: m.role, content: m.content } } +
      [{ role: "user", content: current_message }]
  end

  def over_daily_limit?(user)
    cache_key = "ai_usage:#{user.id}:#{Date.today}"
    Rails.cache.fetch(cache_key, expires_in: 24.hours) { 0 } >= DAILY_REQUEST_LIMIT
  end

  def increment_user_usage(user)
    cache_key = "ai_usage:#{user.id}:#{Date.today}"
    current = Rails.cache.fetch(cache_key, expires_in: 24.hours) { 0 }
    Rails.cache.write(cache_key, current + 1)
  end
end
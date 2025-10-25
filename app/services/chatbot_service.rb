require "openai"

class ChatbotService
  DAILY_REQUEST_LIMIT = (ENV["DAILY_LIMIT"]&.to_i || 50).freeze
  MAX_TOKENS_DEFAULT  = (ENV["OPENAI_MAX_TOKENS"]&.to_i || 400).freeze
  DEFAULT_MODEL       = ENV["OPENAI_CHAT_MODEL"] || "gpt-4o-mini"

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

    context = gather_relevant_context(message)
    system_prompt = <<~PROMPT
      Du bist ein deutschsprachiger Lehrstuhl-Assistent.
      Nutze, wenn möglich, die folgenden Abschlussarbeits-Informationen:
      ---
      #{context.presence || "Keine passenden Abschlussarbeiten gefunden."}
      ---
      Beantworte Fragen sachlich, prägnant und nur basierend auf diesen Daten.
    PROMPT

    conversation = build_conversation_history(user, message)

    response = @client.chat(
      parameters: {
        model: DEFAULT_MODEL,
        messages: [
          { role: "system", content: system_prompt },
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

  def gather_relevant_context(message)
    RagContextService.new.formatted_context(message)
  rescue => e
    Rails.logger.error "[RAG] Fehler beim Laden des Kontexts: #{e.message}"
    ""
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

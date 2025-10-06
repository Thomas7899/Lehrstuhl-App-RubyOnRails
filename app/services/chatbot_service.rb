require "openai"

class ChatbotService
  include Rails.application.routes.url_helpers

  def initialize
    key = ENV["OPENAI_API_KEY"]
    unless key&.strip&.start_with?("sk-")
      Rails.logger.warn "[Chatbot] OPENAI_API_KEY nicht gesetzt oder verdächtig (length=#{key&.length || 0})"
      @api_unavailable = true
      return
    end
    @client = OpenAI::Client.new(access_token: key)
  end

  def generate_response(message, user)
    # Kontext über den Lehrstuhl und die App aufbauen
    system_prompt = build_system_prompt(user)

    # Conversation History abrufen
    conversation_history = build_conversation_history(user, message)
    Rails.logger.info "[Chatbot] Generating response | user_id=#{user.id} | history_count=#{conversation_history.size} | msg='#{message.tr("\n", ' ')[0, 120]}...'"

    begin
      if @api_unavailable
        return fallback_answer("API-Key fehlt")
      end
      attempts = 0
      begin
        attempts += 1
        response = @client.chat(
          parameters: {
            model: (ENV["OPENAI_CHAT_MODEL"] || "gpt-4o-mini"),
            messages: [
              { role: "system", content: system_prompt },
              *conversation_history
            ],
              temperature: 0.7,
              max_tokens: (ENV["OPENAI_MAX_TOKENS"]&.to_i || 300),
              top_p: 1.0,
              frequency_penalty: 0.0,
              presence_penalty: 0.0
          }
        )
      rescue Faraday::TooManyRequestsError => e
        if attempts < 2
          sleep 1.2
          retry
        else
          Rails.logger.warn "[Chatbot] Rate limit after #{attempts} attempts"
          return fallback_answer("Rate-Limit erreicht – bitte kurz warten")
        end
      rescue Faraday::UnauthorizedError
        return fallback_answer("Ungültiger oder abgelaufener API-Key")
      end

      if response.nil?
        Rails.logger.error "[Chatbot] OpenAI response was nil"
        return fallback_answer("Leerer API-Response")
      end

      if response.is_a?(Hash) && response["error"]
        Rails.logger.error "[Chatbot] OpenAI API Error: #{response['error'].inspect}"
        return fallback_answer(response["error"]["message"])
      end

      text = response.dig("choices", 0, "message", "content")
      unless text
        Rails.logger.error "[Chatbot] Unexpected response structure: #{response.inspect[0, 400]}"
        return fallback_answer("Unerwartete API-Struktur")
      end

      text
    rescue StandardError => e
      Rails.logger.error "[Chatbot] Exception: #{e.class}: #{e.message}\n#{e.backtrace.first(5).join("\n")}"
      fallback_answer(e.message)
    end
  end

  private

  def build_system_prompt(user)
    # Dynamischer Kontext basierend auf verfügbaren Daten
    context_info = gather_user_context(user)

    <<~PROMPT
      Du bist ein deutschsprachiger Assistent für eine Hochschul-Lehrstuhl-App.
      Ziele: Navigationshilfe, Fragen zu Abschlussarbeiten, kurze Funktions-Erklärungen.
      Stil: knapp, sachlich, hilfreich. Keine Wiederholungen, kein Smalltalk.
      Nutzer: #{context_info.presence || 'Basisnutzer'}
      Wenn Frage unklar -> höflich Rückfrage.
    PROMPT
  end

  def gather_user_context(user)
    context = []
    context << "Email: #{user.email_address}" if user.email_address

    # Da User und Student verschiedene Modelle sind,
    # arbeiten wir erstmal nur mit den User-Informationen
    # In der Zukunft könnte man eine Verbindung zwischen User und Student herstellen

    context.join("\n")
  end

  def build_conversation_history(user, current_message)
  # Letzte 5 Nachrichten für schlankeren Kontext
  recent_messages = ChatMessage.conversation_history(user).last(5)

    history = recent_messages.map do |msg|
      {
        role: msg.role,
        content: msg.content
      }
    end

    # Aktuelle Nachricht hinzufügen
    history << { role: "user", content: current_message }

    history
  end

  def fallback_answer(detail)
    "(Hinweis: KI vorübergehend nicht verfügbar – #{detail})"
  end
end

class ChatbotController < ApplicationController
  before_action :ensure_json_request, only: [:create]
  skip_before_action :require_authentication, only: [:index, :create, :clear_history]
  skip_before_action :verify_authenticity_token, only: [:create, :clear_history], if: :json_request?
  before_action :log_request_info, only: [:create]

  def index
    user = Current.user || User.first
    @chat_messages = user&.chat_messages&.order(:created_at)&.last(50) || []
  end

  def create
    user = Current.user || User.first
    return render json: { error: "Kein Benutzer gefunden." }, status: :unauthorized unless user

    message_text = params[:message].to_s.strip
    return render json: { error: "Nachricht darf nicht leer sein." }, status: :bad_request if message_text.blank?

    Rails.logger.info "[Chatbot] User #{user.id} sent: '#{message_text[0, 60]}...'"

    detect_duplicate_request(user, message_text)

    user_message = user.chat_messages.create!(role: "user", content: message_text)
    ai_response = ChatbotService.new.generate_response(message_text, user)
    bot_message = user.chat_messages.create!(role: "assistant", content: ai_response)

    Rails.logger.info "✅ [ChatbotController] Anfrage verarbeitet (#{request.uuid})"

    render json: {
      success: true,
      bot_message: {
        id: bot_message.id,
        content: bot_message.content,
        role: bot_message.role,
        timestamp: bot_message.created_at.strftime("%H:%M")
      }
    }
  rescue => e
    Rails.logger.error "[Chatbot] ERROR: #{e.message}"
    render json: {
      success: false,
      error: e.message,
      bot_message: {
        content: "Entschuldigung, ich kann im Moment nicht antworten. Bitte versuchen Sie es später erneut.",
        role: "assistant",
        timestamp: Time.current.strftime("%H:%M")
      }
    }, status: :internal_server_error
  end

  def clear_history
    user = Current.user || User.first
    count = user&.chat_messages&.delete_all || 0
    render json: { success: true, deleted_count: count }
  end

  private

  def ensure_json_request
    unless json_request?
      render json: { error: "Nur JSON-Requests sind erlaubt." }, status: :unsupported_media_type
    end
  end

  def json_request?
    request.format.json? || request.content_type&.include?("application/json")
  end

  def log_request_info
    Rails.logger.info "🔎 [ChatbotController] Neue Anfrage empfangen"
    Rails.logger.info "   • Request-ID: #{request.uuid}"
    Rails.logger.info "   • User-ID: #{Current.user&.id || 'n/a'}"
    Rails.logger.info "   • Pfad: #{request.path}"
    Rails.logger.info "   • Methode: #{request.method}"
    Rails.logger.info "   • Remote-IP: #{request.remote_ip}"
    Rails.logger.info "   • User-Agent: #{request.user_agent}"
    Rails.logger.info "   • Zeit: #{Time.current}"
  end

  def detect_duplicate_request(user, message)
    cache_key = "chatbot:last_request:#{user.id}"
    last_request = Rails.cache.read(cache_key)
    now = Time.current

    if last_request && last_request[:message] == message && now - last_request[:time] < 2.seconds
      Rails.logger.warn "⚠️  [ChatbotController] Doppelte Anfrage erkannt für User #{user.id}: '#{message}'"
    end

    Rails.cache.write(cache_key, { message: message, time: now }, expires_in: 5.minutes)
  end
end

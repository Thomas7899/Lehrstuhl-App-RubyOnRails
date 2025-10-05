class ChatbotController < ApplicationController
  # Stellt sicher, dass Aktionen (außer index) nur über JS aufgerufen werden
  before_action :ensure_ajax_request, except: [:index]
  
  # Überspringt die CSRF-Prüfung für JSON-Anfragen, da diese anders gesichert sind
  skip_before_action :verify_authenticity_token, only: [:create, :clear_history], if: :json_request?

  # Zeigt die Chat-Seite mit dem bisherigen Verlauf an
  def index
    @chat_messages = Current.user.chat_messages.order(:created_at).last(50)
  end

  # Verarbeitet eine neue Nachricht vom Benutzer und generiert eine KI-Antwort
  def create
    @message = params[:message]&.strip

    if @message.blank?
      render json: { error: 'Nachricht darf nicht leer sein.' }, status: :bad_request
      return
    end

    begin
      Rails.logger.info "[Chatbot] User #{Current.user.id} sent: '#{@message[0, 50]}...'"

      # 1. Speichere die Nachricht des Benutzers
      Current.user.chat_messages.create!(role: 'user', content: @message)

      # 2. Generiere eine Antwort vom ChatbotService
      ai_response_content = ChatbotService.new.generate_response(@message, Current.user)
      Rails.logger.info "[Chatbot] AI response: '#{ai_response_content[0, 50]}...'"

      # 3. Speichere die Antwort der KI
      bot_message = Current.user.chat_messages.create!(role: 'assistant', content: ai_response_content)

      # 4. Sende die erfolgreiche Antwort als JSON zurück
      render json: {
        success: true,
        bot_message: {
          id: bot_message.id,
          content: bot_message.content,
          role: bot_message.role,
          timestamp: bot_message.created_at.strftime('%H:%M')
        }
      }

    rescue => e
      # Fängt alle möglichen Fehler ab (OpenAI API, Datenbank, etc.)
      Rails.logger.error "[Chatbot] FATAL ERROR in create: #{e.class}: #{e.message}"
      Rails.logger.error "[Chatbot] Backtrace: #{e.backtrace.first(5).join("\n")}"

      # Sende eine standardisierte Fehlermeldung als JSON zurück
      render json: {
        success: false,
        error: "Ein interner Fehler ist aufgetreten: #{e.message}",
        bot_message: {
          id: "error-#{Time.now.to_i}",
          content: "Entschuldigung, ich kann im Moment nicht antworten. Bitte versuchen Sie es später erneut.",
          role: 'assistant',
          timestamp: Time.now.strftime('%H:%M')
        }
      }, status: :internal_server_error
    end
  end

  # Löscht den gesamten Chat-Verlauf des aktuellen Benutzers
  def clear_history
    deleted_count = Current.user.chat_messages.delete_all
    Rails.logger.info "[Chatbot] Cleared #{deleted_count} messages for user #{Current.user.id}"

    render json: {
      success: true,
      message: 'Chat-Verlauf wurde erfolgreich gelöscht.',
      deleted_count: deleted_count
    }
  end

  private

  # Stellt sicher, dass die Anfrage eine JavaScript-Hintergrundanfrage ist
  def ensure_ajax_request
    unless request.xhr? || json_request?
      redirect_to root_path, alert: 'Dieser Endpunkt ist nur für AJAX-Anfragen verfügbar.'
    end
  end

  # Prüft, ob das Anfrageformat JSON ist
  def json_request?
    request.format.json? || request.content_type&.include?('application/json')
  end
end
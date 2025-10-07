class ChatMessagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :set_student, only: [ :index, :create, :show ]
  before_action :set_chat_message, only: [ :show ]

  def index
    @messages = ChatMessage.where(user: @student).order(:created_at)
    render json: @messages
  end

  def create
    permitted_params = chat_message_params
    return if performed?

    @message = ChatMessage.new(permitted_params)
    @message.user = @student

    if @message.save
      render json: @message, status: :created
    else
      render json: @message.errors, status: :unprocessable_content
    end
  end

  def show
    render json: @message
  end

  private

  def set_student
    student_id = params[:user_id] || params[:student_id]
    @student = Student.find(student_id)
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Student not found" }, status: :not_found
  end

  def set_chat_message
    @message = ChatMessage.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Message not found" }, status: :not_found
  end

  def chat_message_params
  # Fall 1: Standard Rails nested parameters
  if params[:chat_message].present?
    begin
      return params.require(:chat_message).permit(:content, :role)
    rescue ActionController::ParameterMissing
      render json: { error: "Missing chat_message parameters" }, status: :bad_request and return
    end
  end

  # Fall 2: Strikte Prüfung für flache Parameter
  if params[:content].present? && params[:role].present?
    return { content: params[:content], role: params[:role] }
  end

  # Fall 3: Keine gültigen Parameter gefunden -> Fehler rendern und stoppen
  render json: {
    error: "Invalid or missing parameters",
    details: "Request must include either a nested 'chat_message' object or flat 'content' and 'role' parameters.",
    expected_format: {
      chat_message: {
        content: "Your message content",
        role: "user"
      }
    }
  }, status: :bad_request
end
end

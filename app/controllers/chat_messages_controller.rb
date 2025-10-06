class ChatMessagesController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  before_action :set_student, only: [:index, :create, :show]
  before_action :set_chat_message, only: [:show]

  def index
    @messages = ChatMessage.where(user: @student).order(:created_at)
    render json: @messages
  end

  def create
    @message = ChatMessage.new(chat_message_params)
    @message.user = @student

    if @message.save
      render json: @message, status: :created
    else
      render json: @message.errors, status: :unprocessable_entity
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
    render json: { error: 'Student not found' }, status: :not_found
  rescue => e
    render json: { error: "Invalid student parameter: #{e.message}" }, status: :bad_request
  end

  def set_chat_message
    @message = ChatMessage.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Message not found' }, status: :not_found
  end

  def chat_message_params
    params.require(:chat_message).permit(:content, :role)
  end
end
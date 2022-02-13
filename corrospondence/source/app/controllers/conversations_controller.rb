class ConversationsController < ApplicationController
  # before_action :authenticate
  before_action :find_forum
  before_action :set_conversation, only: %i[ show update destroy ]

  # GET /conversations
  def index
    render json: @forum.conversations
  end

  # GET /conversations/1
  def show
    render json: @conversation
  end

  # POST /conversations
  def create
    @conversation = @forum.conversations.build(conversation_params)

    if @conversation.save
      render json: @conversation, status: :created
    else
      render json: @conversation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /conversations/1
  def update
    if @conversation.update(conversation_params)
      render json: @conversation
    else
      render json: @conversation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /conversations/1
  def destroy
    @conversation.destroy
  end

  private

    def find_forum
      @forum = Forum.find(params[:forum_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_conversation
      @conversation = @forum.conversations.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def conversation_params
      params.require(:conversation).permit(:topic, :summary, :content_owner_id, :forum_id)
    end
end

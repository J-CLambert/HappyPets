class MessagesController < ApplicationController
  def show
    @messenger = Messenger.find(params[:id])
    @message = Message.new
  end

  def create
    @messenger = Messenger.find(params[:id])
    @message = Message.new(message_params)
    @message.messenger = @messenger
    @message.user = current_user
    if @message.save
      MessengerChannel.broadcast_to(
        @messenger,
        render_to_string(partial: "message", locals: { message: @message })
      )
      head :ok
    else
      render "messengers/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end

class MessengerChannel < ApplicationCable::Channel
  def subscribed
    messenger = Messenger.find(params[:id])
    stream_for messenger
  end

  def unsubscribed
    stop_all_streams # Any cleanup needed when channel is unsubscribed
  end
end

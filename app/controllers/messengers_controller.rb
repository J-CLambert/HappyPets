class MessengersController < ApplicationController
  def show
    @messenger = Messenger.find(params[:id])
    @message = Message.new
  end
end

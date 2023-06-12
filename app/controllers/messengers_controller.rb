class MessengersController < ApplicationController
  def show
    @messenger = Messenger.find(params[:id])
  end
end

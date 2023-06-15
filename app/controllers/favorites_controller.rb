class FavoritesController < ApplicationController
  def create
    @pet = Pet.find(params[:pet_id])
    @favorite = Favorite.new
    @favorite.user = current_user
    @favorite.pet = @pet
    respond_to do |format|
      if @favorite.save
        format.js   # <-- will render `app/views/favorites/create.js.erb`
      else
        format.js { render json: @favorite.errors, status: :unprocessable_entity }
      end
    end
  end
end

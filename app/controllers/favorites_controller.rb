class FavoritesController < ApplicationController
  def create
    @pet = Pet.find(params[:pet_id])
    @favorite = @pet.favorites.build(favorite_params)
    @favorite.user = current_user
    respond_to do |format|
      if @favorite.save
        format.js
      else
        format.js { render json: @favorite.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def favorite_params
    params.require(:favorite).permit
  end
end

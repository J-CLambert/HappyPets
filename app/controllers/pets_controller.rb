class PetsController < ApplicationController
  before_action :set_pet, only: %i[show edit update destroy bookings]
  skip_before_action :authenticate_user!, only: :index

  def index
    @pets = Pet.all
  end

  def show
    @request = Request.new
  end

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.new(pet_params)
    @pet.user = current_user
    if @pet.save
      redirect_to pet_path(@pet), notice: "Your pet ad was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    if @pet.update(pet_params)
      redirect_to pet_path(@pet), notice: "Your pet ad was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @pet.destroy
    redirect_to :root, status: :see_other
  end

  private

  def set_pet
    @pet = Pet.find(params[:id])
  end

  def pet_params
    params.require(:pet).permit(:name, :price, :breed, :description, :title, :birthday, :vaccinated_against, :species)
  end
end

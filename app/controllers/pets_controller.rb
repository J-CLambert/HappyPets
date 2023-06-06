class PetsController < ApplicationController
  before_action :set_pet, only: %i[show edit update destroy bookings]

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
    respond_to do |format|
      if @pet.save
        format.html { redirect_to pet_path(@pet), notice: "Your pet ad was successfully created." }
        format.json { render :show, status: :created, location: @pet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @pet.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    respond_to do |format|
      if @pet.update(pet_params)
        format.html { redirect_to pet_url(@pet), notice: "Your pet ad was successfully updated." }
        format.json { render :show, status: :ok, location: @pet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @pet.errors, status: :unprocessable_entity }
      end
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
    params.require(:pet).permit(:name, :price, :description, :title, :birthday, :vaccinated_against, :species)
  end
end

class PetsController < ApplicationController
  before_action :set_pet, only: %i[show edit update destroy bookings]
  skip_before_action :authenticate_user!, only: :search
  def index
    @pets = Pet.all
    pet = params.dig(:search, :pet)
    address = params.dig(:search, :address)

    if params[:species]
      @pets = Pet.where(species: params[:species])
    elsif address.present? && pet.present?
      users = User.near(address, 10)
      results = PgSearch.multisearch(pet)
      pets = results.map(&:searchable)
      @pets = pets.select { |pet| pet && users.include?(pet.user) }
    elsif address.present?
      users = User.near(address, 10)
      @pets = Pet.where(user_id: users.map(&:id))
    elsif pet.present?
      pets = PgSearch.multisearch(pet)
      pets = pets.map(&:searchable)
      @pets = pets.select { |pet| pet }
    end
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
    params.require(:pet).permit(:name, :price, :description, :breed ,:title, :birthday, :vaccinated_against, :species, photos: [])
  end
end

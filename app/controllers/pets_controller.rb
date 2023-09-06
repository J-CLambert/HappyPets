class PetsController < ApplicationController
  before_action :set_pet, only: %i[show edit update destroy bookings]
  skip_before_action :authenticate_user!, only: :index

  def index
    @pets = Pet.all
    filter_by_species if params[:species]
    filter_by_search_params if params.dig(:search, :pet) || params.dig(:search, :address)
  end

  def filter_by_species
    @pets = Pet.where(species: params[:species])
  end

  def filter_by_search_params
    pet = params.dig(:search, :pet)
    address = params.dig(:search, :address)

    if address.present?
      users_near_address = User.near(address, 10)
      @pets = Pet.where(user_id: users_near_address.map(&:id))
    end

    return unless pet.present?

    pets_results = PgSearch.multisearch(pet).map(&:searchable)
    @pets = pets_results.select do |pet_result|
      pet_result && (address.blank? || users_near_address.include?(pet_result.user))
    end
  end

  def index_breeder
    @pets = Pet.where(user: current_user)
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
    redirect_to index_breeder_pets_path
  end

  private

  def set_pet
    @pet = Pet.find(params[:id])
  end

  def pet_params
    params.require(:pet).permit(:name, :price, :description, :breed, :title, :birthday, :vaccinated_against, :species,
                                photos: [])
  end
end

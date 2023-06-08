class RequestsController < ApplicationController
  before_action :set_pet, only: %i[new create]
  before_action :set_request, only: %i[show edit update destroy confirm]
  # skip_before_action :authenticate_user!, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  def index
    @requests = Request.all
  end

  def show; end

  def requested
    if current_user.breeder
      @requests = Request.where(pet: current_user.pets)
    else
      @request = current_user.requests
    end
  end

  def confirm
    @request.confirmed_visit!
    if @request.confirmed_visit!
      flash[:notice] = 'Request confirmed successfully'
    else
      flash[:alert] = 'There was an error confirming this request'
    end
  end

  def new
    @request = Request.new
  end

  def create
    @request = Request.new(request_params)
    @request.user = current_user
    @request.pet = @pet

    respond_to do |format|
      if @request.save
        format.html { redirect_to request_url(@request), notice: "Request was successfully created." }
        format.json { render :show, status: :created, location: @pet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit; end

  def update
    respond_to do |format|
      if @request.update(request_params)
        format.html { redirect_to request_url(@request), notice: "request was successfully updated." }
        format.json { render :show, status: :ok, location: @request }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @request.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @request.destroy
    redirect_to requests_path, notice: 'request was successfully deleted.'
  end

  private

  def set_request
    @request = request.find(params[:id])
  end

  def request_params
    params.require(:request).permit(:title, :visit_date, :message)
  end

  def set_pet
    @pet = Pet.find(params[:pet_id])
  end
end

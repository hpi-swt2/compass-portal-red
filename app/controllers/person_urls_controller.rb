class PersonUrlsController < ApplicationController
  before_action :set_person_url, only: %i[ show edit update destroy ]
  #For avoiding authenticity checking:
  skip_before_action :verify_authenticity_token 
  # GET /person_urls or /person_urls.json
  def index
    @person_urls = PersonUrl.all
  end

  # GET /person_urls/1 or /person_urls/1.json
  def show
  end

  # GET /person_urls/new
  def new
    @person_url = PersonUrl.new
  end

  # GET /person_urls/1/edit
  def edit
  end

  # POST /person_urls or /person_urls.json
  def create
    #@person_url = PersonUrl.new(person_url_params)

    begin
      PersonUrl.transaction do
        @person_url = PersonUrl.create!(person_url_params)
      end
    rescue ActiveRecord::RecordInvalid => exception
      @person_url = {
        error: {
          status: 422,
          message: exception
        }
      }
    end
    render json: @person_url
  end

  # PATCH/PUT /person_urls/1 or /person_urls/1.json
  def update
    respond_to do |format|
      if @person_url.update(person_url_params)
        format.html { redirect_to @person_url, notice: "Person url was successfully updated." }
        format.json { render :show, status: :ok, location: @person_url }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @person_url.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /person_urls/1 or /person_urls/1.json
  def destroy
    @person_url.destroy
    respond_to do |format|
      format.html { redirect_to person_urls_url, notice: "Person url was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_person_url
      @person_url = PersonUrl.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def person_url_params
      params.permit( [:name, :url]).require(:person_urls)
    end
end

class PersonUrlsController < ApplicationController
  before_action :set_person_url, only: %i[show edit update destroy]
  # For avoiding authenticity checking:
  skip_before_action :verify_authenticity_token, only: [:create]
  # GET /person_urls or /person_urls.json
  def index
    @person_urls = PersonUrl.all
  end

  def show
    # show one person
  end

  # GET /person_urls/new
  def new
    @person_url = PersonUrl.new
  end

  def edit
    # edit a peroson
  end

  # POST /person_urls or /person_urls.json
  def create
    # @person_url = PersonUrl.new(person_url_params)
    PersonUrl.delete_all
    begin
      PersonUrl.transaction do
        @person_url = PersonUrl.create!(person_url_params)
      end
    rescue ActiveRecord::RecordInvalid => e
      @person_url = {
        error: {
          status: 422,
          message: e
        }
      }
    end
    render json: @person_url
  end

  def update
    # update database
  end

  def destroy
    # delete person
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_person_url
    @person_url = PersonUrl.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def person_url_params
    params.permit([:name, :url]).require(:person_urls)
  end
end

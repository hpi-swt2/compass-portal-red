require "#{Rails.root}/lib/scraping/hpi_data_collector.rb"
require "#{Rails.root}/lib/scraping/scraping_exception.rb"

class PeopleController < ApplicationController
  before_action :set_person, only: %i[show edit update destroy]

  # GET /people or /people.json
  def index
    @people = Person.all
  end

  # GET /people/1 or /people/1.json
  def show; end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit; end

  # POST /people or /people.json
  def create
    @person = Person.new(person_params)

    respond_to do |format|
      if @person.save
        format.html { redirect_to @person, notice: "Person was successfully created." }
        format.json { render :show, status: :created, location: @person }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /people/1 or /people/1.json
  def update
    respond_to do |format|
      if @person.update(person_params)
        format.html { redirect_to @person, notice: "Person was successfully updated." }
        format.json { render :show, status: :ok, location: @person }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1 or /people/1.json
  def destroy
    @person.destroy
    respond_to do |format|
      format.html { redirect_to people_url, notice: "Person was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def scrape
    # Read urls from database (TODO)
    # url_records = Url.all

    data_collector = HpiDataCollector.new
    # url_records.each do |record|
    urls.each do |url|
      item = {}
      # name_hash = dataCollector.get_names(record[:name])
      name_hash = data_collector.get_names(url[0])
      title_hash = data_collector.get_title(url[0])

      begin
        # Scrape and get info
        # info_hash = dataCollector.get_scraping_info(record[:url])
        info_hash = data_collector.get_scraping_info(url[0], url[1])
      rescue ScrapingException => e
        next
      end

      handle_person(item.merge(name_hash).merge(title_hash).merge(info_hash))
    end
  end

  def handle_person(item)
    # If person exists update non-existent attributes, else create new person
    person = Person.find_by(name: item[:name], surname: item[:surname])
    if person
      person.email = item[:email] unless person.email
      person.phone = item[:phone] unless person.phone
      person.office = item[:office] unless person.office
      person.save
    else
      Person.where(item).first_or_create
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_person
    @person = Person.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def person_params
    params.require(:person).permit(:name, :surname, :title, :email, :phone, :office, :website, :image, :chair,
                                   :office_hours, :telegram_handle, :knowledge)
  end
end

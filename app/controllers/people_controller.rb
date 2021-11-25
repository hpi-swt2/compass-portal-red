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
    # Read url file
    lines = [['', '']]

    # Call HpiWebScraper for every (name, url) pair
    webscraper = HpiWebScraper.new
    
    lines.each do |name, url|
      item = {}
      # Get name
      name_hash = webscraper.getNames(name)

      # Scrape and get info
      info_hash = webscraper.getScrapingInfo(url)

      item = item.merge(name_hash).merge(info_hash)

      # If person exists update non-existant attributes, else create new person
      person = Person.find_by(name: item[:name], surname: item[:surname])
      if person then
        if !person.email then
          person.email = item[:email]
        end
        if !person.phone then
          person.phone = item[:phone]
        end
        if !person.office then
          person.office = item[:office]
        end
        person.save
      else
        Person.where(item).first_or_create
      end
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

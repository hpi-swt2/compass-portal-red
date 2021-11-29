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
    # Read url file
    # url_records = Url.all

    dataCollector = HpiDataCollector.new

    urls = [['Valeska Maul', '/hoelzle/team/wissenschaftliche-beschaeftigte/valeska-maul'], 
    ['Hannah Marienwald', '/rabl/team/hannah-marienwald'], 
    ['Prof. Dr. Holger Giese', '/das-hpi/personen/professoren/prof-dr-holger-giese'], 
    ['Aikaterini Niklanovits', '/research-schools/hpi-dse/mitglieder/research-pages/aikaterini-niklanovits'], 
    ['Martin Schwemmle', '/school-of-design-thinking/hpi-d-school/team/martin-schwemmle'], 
    ['Prof. Hasso Plattner', '/prof-hasso-plattner'], 
    ['Christine Schnaithmann', '/school-of-design-thinking/hpi-d-school/coaches/christine-schnaithmann'], 
    ['Prof. Dr. Holger Karl', '/das-hpi/personen/professoren/prof-dr-holger-karl'], 
    ['Dr. Timm Krohn', '/school-of-design-thinking/hpi-d-school/coaches/dr-timm-krohn'], 
    ['Gerardo Vitagliano', '/research-schools/hpi-dse/mitglieder/research-pages/gerardo-vitagliano'], 
    ['Dr. Christoph Böhm', '/christoph-boehm'], 
    ['Prof. Christoph Meinel', '/das-hpi/veranstaltungen/konferenzen/potsdamer-sicherheitskonferenz/dokumentation/dokumentation-2015/prof-christoph-meinel'], 
    ['Suparno Datta', '/boettinger/team/suparno-datta'], 
    ['Jan Schmiedgen', '/dtrp/personen/alumni/jan-schmiedgen'], 
    ['Prof. Dr. Christian Dörr', '/das-hpi/personen/professoren/prof-dr-christian-doerr'], 
    ['Dr. Thorsten Papenbrock', '/naumann/dr-thorsten-papenbrock'], 
    ['Thomas Bodner', '/plattner/people/phd-students/thomas-bodner'], 
    ['Tamara Slosarek', '/boettinger/team/tamara-slosarek'], 
    ['Diana Stephan', '/mueller/personen/diana-stephan'], 
    ['Ferdous Nasri', '/renard/team/ferdous-nasri'], 
    ['Daniel Richter', '/forschung/research-schools/standorte/das-hasso-plattner-institut/mitglieder/daniel-richter'], 
    ['Oliver Kullik', '/hoelzle/team/wissenschaftliche-beschaeftigte/oliver-kullik'], 
    ['Samuel Tschepe', '/school-of-design-thinking/hpi-d-school/team/samuel-tschepe'], 
    ['Dr. Alexander Zeier', '/dtrp/people/alumni/dr-alexander-zeier'], 
    ['Zhe Zuo', '/naumann/people/zhe-zuo'], 
    ['Janosch Ruff', '/friedrich/people/janosch-ruff'], 
    ['Pascal Lenzner', '/friedrich/people/pascal-lenzner'], 
    ['Francesco Quinzan', '/friedrich/publications/people/francesco-quinzan'], 
    ['Marta Lemanczyk', '/research-schools/hpi-dse/mitglieder/research-pages/marta-stefania-lemanczyk'], 
    ['Markus Dreseler', '/plattner/people/phd-students/markus-dreseler'], 
    ['Lutz Gericke', '/dtrp/personen/alumni/lutz-gericke'], 
    ['Dr. Mariana Neves', '/plattner/people/alumni/dr-mariana-neves'], 
    ['Tim Repke', '/naumann/people/tim-repke'], 
    ['Abhinaya Kasoju', '/dtrp/people/alumni/abhinaya-kasoju'], 
    ['Thomas Unterholzer', '/dtrp/people/alumni/thomas-unterholzer'], 
    ['Mazhar Hameed', '/research-schools/hpi-dse/mitglieder/research-pages/mazhar-hameed'], 
    ['Alexander Lübbe', '/dtrp/personen/alumni/alexander-luebbe'], 
    ['Eyad Saleh', '/forschung/research-schools/standorte/das-hasso-plattner-institut/mitglieder/eyad-saleh'], 
    ['Prof. Dr. Bert Arnrich', '/the-hpi/people/professors/prof-dr-bert-arnrich'], 
    ['Christopher Hagedorn', '/plattner/people/phd-students/christopher-hagedorn'], 
    ['Dr. Uwe Hentschel', '/forschung/research-schools/standorte/das-hasso-plattner-institut/mitglieder/dr-uwe-hentschel'], 
    ['Tobias Rohloff', '/meinel/lehrstuhl/team/current-phd-students/tobias-rohloff'], 
    ['Dr. Alexander Albrecht', '/naumann/dr-alexander-albrecht']]

    # url_records.each do |record|
    urls.each do |url|

      item = {}
      
      # Get name
      # name_hash = dataCollector.getNames(record[:name])
      name_hash = dataCollector.getNames(url[0])
      
      begin
        # Scrape and get info
        # info_hash = dataCollector.getScrapingInfo(record[:url])
        info_hash = dataCollector.getScrapingInfo(url[1])
      rescue ScrapingException => e
        next
      end

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

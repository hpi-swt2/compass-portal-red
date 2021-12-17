class PeopleController < ApplicationController
  before_action :set_person, only: %i[show edit update destroy]
  default_form_builder HighlightableFormBuilder

  # GET /people or /people.json
  def index
    @people = Person.all
  end

  # GET /people/1 or /people/1.json
  def show
    @person = Person.includes(:informations).find(params[:id])
  end

  # GET /people/new
  def new
    @person = Person.new
  end

  # GET /people/1/edit
  def edit
    @params = params
  end

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

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_person
    @person = Person.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def person_params
    process_human_verified_attributes
    params.require(:person).permit(:first_name, :last_name, :title, :email, :status, :phone, :room, :website,
                                   :image, :chair,
                                   *Person.verification_attributes)
  end

  # Replaces all human_verified params with the current timestamp, if set to true
  def process_human_verified_attributes
    Person.verification_attributes.each do |verification_attr|
      if params[:person][verification_attr] == "1"
        params[:person][verification_attr] = DateTime.now
        delete_data_problem(:person, verification_attr)
      else
        params[:person].delete verification_attr
      end
    end
  end

  def delete_data_problem(person, verification_attr)
    field = verified_attribute_to_field(verification_attr)
    DataProblem.where(["person_id = ? and field = ?", person.id, field]).destroy_all
  end
end

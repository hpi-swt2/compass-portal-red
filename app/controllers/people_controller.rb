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
        delete_data_problem(@person)
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
    # TODO: Update for new schema

    process_human_verified_attributes
    params.require(:person).permit(:first_name, :last_name, :title, :email, :status, :phone, :room, :website,
                                   :image, :chair,
                                   :human_verified_first_name, :human_verified_last_name, :human_verified_title,
                                   :human_verified_email, :human_verified_image, :human_verified_room_id)
  end

  def process_human_verified_attributes
    [:human_verified_first_name, :human_verified_last_name, :human_verified_title,
     :human_verified_email, :human_verified_image, :human_verified_room_id].each do |attr|

      params[:person][attr] = if params[:person][attr] == "1"
                                DateTime.now
                              else
                                @person[attr]
                              end

    end
  end

  def delete_data_problem(person)
    DataProblem.where(person_id: person.id).destroy_all
  end
end

class DataProblemsController < ApplicationController
  before_action :set_data_problem, only: %i[show edit update destroy]

  # GET /data_problems or /data_problems.json
  def index
    @data_problems = DataProblem.all
  end

  # GET /data_problems/1 or /data_problems/1.json
  def show; end

  # GET /data_problems/new
  def new
    @data_problem = DataProblem.new
  end

  # GET /data_problems/1/edit
  def edit; end

  # POST /data_problems or /data_problems.json
  def create
    @data_problem = DataProblem.new(data_problem_params)

    respond_to do |format|
      if @data_problem.save
        format.html { redirect_to @data_problem, notice: "Data problem was successfully created." }
        format.json { render :show, status: :created, location: @data_problem }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @data_problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /data_problems/1 or /data_problems/1.json
  def update
    respond_to do |format|
      if @data_problem.update(data_problem_params)
        format.html { redirect_to @data_problem, notice: "Data problem was successfully updated." }
        format.json { render :show, status: :ok, location: @data_problem }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @data_problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /data_problems/1 or /data_problems/1.json
  def destroy
    @data_problem.destroy
    respond_to do |format|
      format.html { redirect_to data_problems_url, notice: "Data problem was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_data_problem
    @data_problem = DataProblem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def data_problem_params
    params.require(:data_problem).permit(:url, :description, :field, :room_id, :person_id)
  end
end

class EmailLogsController < ApplicationController

  # GET /email_log or /email_log.json
  def index
    @email_log = EmailLog.all
  end

  # GET /email_log/1 or /email_log/1.json
  def show; end

  # GET /email_log/new
  def new
    @email_log = EmailLog.new
  end

  # GET /email_log/1/edit
  def edit; end

  # POST /email_log or /email_log.json
  def create
    @email_log = EmailLog.new(email_log_params)

    respond_to do |format|
      if @email_log.save
        format.html { redirect_to @email_log, notice: "EmailLog was successfully created." }
        format.json { render :show, status: :created, location: @email_log }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @email_log.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_email_log
    @email_log = EmailLog.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def email_log_params
    params.require(:email_log).permit(:email_address, :last_sent, :people_id)
  end
end

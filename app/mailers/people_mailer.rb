include DataProblemsHelper

class PeopleMailer < ApplicationMailer
  default from: 'compass.rot@gmail.com'
  def problem_reminder_email
    @person = params[:person]
    @problems = params[:problems]
    @url = "#{root_url}people/#{@person.id}/edit#{edit_params(@person.id)}"
    # mail(to: @person.email...
    mail(to: @person.email, subject: 'Problem with your data!')
  end
end

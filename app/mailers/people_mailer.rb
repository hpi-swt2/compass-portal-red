class PeopleMailer < ApplicationMailer
  default from: 'compass.rot@gmail.com'
  def problem_reminder_email
    @person = params[:person]
    @problems = params[:problems]
    # @person.email
    @url = root_url + "/people/" + @person.id + "/edit"
    mail(to: 'tfiedler01@yahoo.de', subject: 'Problem with your data!')
    puts 'Email sent!'
  end
end

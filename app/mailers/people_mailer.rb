class PeopleMailer < ApplicationMailer
  default from: 'compass.rot@gmail.com'
  def problem_reminder_email
    @person = params[:person]
    @problems = params[:problems]
    @url = "#{root_url}people/#{@person.id}/edit"
    # mail(to: @person.email...
    mail(to: 'compass.rot@gmail.com', subject: 'Problem with your data!')
    puts 'Email sent!'
  end
end

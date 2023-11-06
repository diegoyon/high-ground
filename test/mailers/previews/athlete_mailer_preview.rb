# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/athlete_mailer
class AthleteMailerPreview < ActionMailer::Preview
  def welcome_email
    AthleteMailer.with(athlete: Athlete.first).welcome_email
  end
end

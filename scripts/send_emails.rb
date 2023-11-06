Athlete.ready.each do |athlete|
  AthleteMailer.with(athlete:).welcome_email.deliver_now
end

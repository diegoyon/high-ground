athletes = Athlete.ready
athletes.each do |athlete|
  AthleteMailer.with(athlete:).welcome_email.deliver_later
end

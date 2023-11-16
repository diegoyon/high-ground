athletes = Athlete.ready

# Send welcome email
athletes.each do |athlete|
  AthleteMailer.with(athlete:).welcome_email.deliver_later
end

# Send information email
athletes.each do |athlete|
  AthleteMailer.with(athlete:).information_email.deliver_later
end

old_athletes = FriAthlete.all

old_athletes.each do |old_athlete|

  athlete = Athlete.create!(
    first_name: old_athlete.first_name,
    last_name: old_athlete.last_name,
    email: old_athlete.email,
    phone: old_athlete.phone,
    tshirt_size: old_athlete.tshirt_size,
    tshirt_name: old_athlete.tshirt_name,
    box: old_athlete.box,
    division: old_athlete.division,
    created_at: old_athlete.created_at,
    updated_at: old_athlete.updated_at
  )

  fri_checkout = FriCheckout.create!(
    fri_username: old_athlete.fri_username,
    transaction_id: old_athlete.transaction_id,
    fri_request_payment_response: old_athlete.fri_request_payment_response,
    fri_webhook_response: old_athlete.fri_webhook_response,
    created_at: old_athlete.created_at,
    updated_at: old_athlete.updated_at
  )

  payment = Payment.create!(
    athlete: athlete,
    payment_status: old_athlete.payment_status,
    paymentable: fri_checkout,
    created_at: old_athlete.created_at,
    updated_at: old_athlete.updated_at
  )

  athlete.payment = payment
  athlete.save!
end

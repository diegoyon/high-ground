json.extract! athlete, :id, :first_name, :last_name, :email, :phone, :created_at, :updated_at
json.url athlete_url(athlete, format: :json)

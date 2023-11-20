athletes = Athlete.ready.where(division: "Scaled Masculino").order(:rank)

csv_file_path = 'scaled_masculino.csv'
CSV.open(csv_file_path, 'wb') do |csv|
  csv << [
    'Nombre',
    'Box'
  ]

  athletes.each do |athlete|
    csv << [
      athlete.full_name,
      athlete.box
    ]
  end
end

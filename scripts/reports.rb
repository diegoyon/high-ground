athletes = Athlete.ready.where(division: "RX Masculino").order(:created_at)

csv_file_path = 'rx_masculino.csv'
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

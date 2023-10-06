######################1
athlete = Athlete.new(
  first_name: 'Diego',
  last_name: 'Mendoza',
  email: 'dmb1912@gmail.com',
  phone: '55250009',
  tshirt_size: 'L',
  box: 'B. Box Training',
  division: 'RX Masculino',
)

deposit = BankDeposit.create!(amount: 500)

athlete.build_payment(
  payment_status: 'completed',
  paymentable: deposit
)

athlete.save!

######################2
athlete = Athlete.new(
  first_name: 'Isabella Sofía',
  last_name: 'Mendoza Berganza',
  email: 'isaisabellamendoza20@agustiniano.edu.gt',
  phone: '33829422',
  tshirt_size: 'XS',
  box: 'B. Box Training',
  division: 'Scaled Femenino',
)

deposit = BankDeposit.create!(amount: 500)

athlete.build_payment(
  payment_status: 'completed',
  paymentable: deposit
)

athlete.save!

######################3
athlete = Athlete.new(
  first_name: 'Jose',
  last_name: 'Davila',
  email: 'jose.davilsasoto@gmail.com',
  phone: '53189931',
  tshirt_size: 'L',
  box: 'B. Box Training',
  division: 'Intermedio Masculino',
)

deposit = BankDeposit.create!(amount: 500)

athlete.build_payment(
  payment_status: 'completed',
  paymentable: deposit
)

athlete.save!

######################4
athlete = Athlete.new(
  first_name: 'Freddy',
  last_name: 'Muñoz',
  email: 'fjmroman@gmail.com',
  phone: '58252289',
  tshirt_size: 'L',
  box: 'Holy Program',
  division: 'RX Masculino',
)

deposit = BankDeposit.create!(amount: 0)

athlete.build_payment(
  payment_status: 'completed',
  paymentable: deposit
)

athlete.save!

######################5
athlete = Athlete.new(
  first_name: 'Diego',
  last_name: 'Morales',
  email: 'morales.luisdiego@gmail.com',
  phone: '59229112',
  tshirt_size: 'M',
  box: 'Oaks CF',
  division: 'RX Masculino',
)

deposit = BankDeposit.create!(amount: 0)

athlete.build_payment(
  payment_status: 'completed',
  paymentable: deposit
)

athlete.save!

######################6
athlete = Athlete.new(
  first_name: 'Josue',
  last_name: 'Ramos',
  email: 'josuecrossfit19@gmail.com',
  phone: '41782059',
  tshirt_size: 'M',
  box: 'Thebox-bbox',
  division: 'RX Masculino',
)

deposit = BankDeposit.create!(amount: 0)

athlete.build_payment(
  payment_status: 'completed',
  paymentable: deposit
)

athlete.save!

######################7
athlete = Athlete.new(
  first_name: 'Héctor',
  last_name: 'Citalan',
  email: 'hectorcitalan_1001@hotmail.com',
  phone: '54127159',
  tshirt_size: 'S',
  tshirt_name: 'Héctor',
  box: 'Crossfit Xela',
  division: 'RX Masculino',
)

deposit = BankDeposit.create!(amount: 0)

athlete.build_payment(
  payment_status: 'completed',
  paymentable: deposit
)

athlete.save!

######################8
athlete = Athlete.new(
  first_name: 'Pamela',
  last_name: 'Hernández',
  email: 'hernandezpamela431@gmail.com',
  phone: '31579970',
  tshirt_size: 'M',
  tshirt_name: 'Pam',
  box: 'Crossfit Xela',
  division: 'Intermedio Femenino',
)

deposit = BankDeposit.create!(amount: 0)

athlete.build_payment(
  payment_status: 'completed',
  paymentable: deposit
)

athlete.save!

######################9
athlete = Athlete.new(
  first_name: 'Hanny Paola',
  last_name: 'Molina Arriola',
  email: 'hannymo19@gmail.com',
  phone: '33919088',
  tshirt_size: 'S',
  tshirt_name: 'MOLINA',
  box: 'Crossfit Xela',
  division: 'Intermedio Femenino',
)

deposit = BankDeposit.create!(amount: 0)

athlete.build_payment(
  payment_status: 'completed',
  paymentable: deposit
)

athlete.save!

######################10
athlete = Athlete.new(
  first_name: 'Diustin Alfredo',
  last_name: 'De Paz Lopez',
  email: 'dius_dpl@hotmail.com',
  phone: '59320027',
  tshirt_size: 'L',
  tshirt_name: 'Dius',
  box: 'Crossfit Xela',
  division: 'Scaled Masculino',
)

deposit = BankDeposit.create!(amount: 0)

athlete.build_payment(
  payment_status: 'completed',
  paymentable: deposit
)

athlete.save!

######################11
athlete = Athlete.find(39)
athlete.update!(
  first_name: 'Ana',
  last_name: 'Hernández',
  email: 'anahg0180@gmail.com',
  phone: '50540770',
  tshirt_size: 'S',
  tshirt_name: 'Anita',
  box: 'Crossfit Xela',
  division: 'Scaled Femenino',
)


athlete = Athlete.new(
  first_name: 'Juan Marcos',
  last_name: 'Arias Morales',
  email: 'ariasmoralesmarcos@gmail.com',
  phone: '58337434',
  tshirt_size: 'L',
  box: '1057 training',
  division: 'Scaled Masculino',
)

deposit = BankDeposit.create!(amount: 650)

athlete.build_payment(
  payment_status: 'completed',
  paymentable: deposit
)

athlete.save!


athlete = Athlete.find(36)
athlete.update!(
  division: 'Intermedio Femenino',
)

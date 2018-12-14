puts "Creating company Brasserie Tout Schuss…"
brasserie = Company.new( name: "Brasserie Tout Schuss")
brasserie.address = "9 rue Ambroise Thomas, Paris"
brasserie.contact_name = "Brice"
brasserie.contact_phone = "+33601010101"
brasserie.save!

puts "Creating one user brasserie@toutchuss.com, password: houblonforever"
user_brasserie = User.create(email: "brasserie@toutschuss.com")
user_brasserie.company = brasserie
user_brasserie.password = "houblonforever"
user_brasserie.save!

puts "Creating company Alias Vert"
Company.create!( name: "Alias Vert")


puts "Creating beer package types…"
PackageType.create!( name: "Pack de 12 bières blondes 33 cl", icon: "https://res.cloudinary.com/dqozfzznu/image/upload/v1544718539/blonde.png")
PackageType.create!( name: "Pack de 12 bières ambrées 33 cl", icon: 'https://res.cloudinary.com/dqozfzznu/image/upload/v1544717932/ambr%C3%A9e.png')
PackageType.create!( name: "Fût de 30 L de bière blonde", icon: "https://res.cloudinary.com/dqozfzznu/image/upload/v1544718555/fut-blonde.png")

puts "Attribute them to Brasserie Tout Schuss…"

PackageType.last(3).each do |t|
  CompanyPackageType.create!(company: brasserie, package_type: t)
end


puts "Creating plants package types…"
PackageType.create!(name: "Grande jardinière 80 cm × 20 cm")
PackageType.create!(name: "Pot de fleur moyen")

tomorrow = Date.tomorrow.to_time
yesterday = Date.yesterday.to_time

puts "Creating a first delivery for Tout Schuss…"

laffitte_delivery = Delivery.new(
  recipient_name: "Olivier",
  recipient_phone: "0602020202",
  address: "43 Rue Laffitte, 75009 Paris",
  complete_after: yesterday + (8 * 60 + 30) * 60,
  complete_before: yesterday + 13 * 60 * 60,
  picked_up_at: yesterday + 9 * 60 * 60,
  delivered_at: yesterday + (9 * 60 + 30) * 60
  )

laffitte_delivery.company = brasserie

puts "Giving it some packages…"

casks_for_delivery = DeliveryPackage.new(
  delivery: laffitte_delivery,
  package_type: PackageType.find_by(name: "Fût de 30 L de bière blonde"),
  amount: 3)
bottles_for_delivery = DeliveryPackage.new(
  delivery: laffitte_delivery,
  package_type: PackageType.find_by(name: "Pack de 12 bières blondes 33 cl"),
  amount: 1)

laffitte_delivery.save!
casks_for_delivery.save!
bottles_for_delivery.save!

today = Date.today.to_time

puts "Adding deliveries already done for today…"

today_delivery = Delivery.new(
  recipient_name: "Céline Balo",
  recipient_phone: "0602020203",
  address: "16 rue de Sambre et Meuse, 75010 Paris",
  complete_after: today + (8 * 60 + 30) * 60,
  complete_before: today + 13 * 60 * 60,
  picked_up_at: today + 12 * 60 * 60,
  delivered_at: today + (12 * 60 + 30) * 60
  )

today_delivery.company = brasserie
today_delivery.save!

today_delivery_2 = Delivery.new(
  recipient_name: "Trainround SAS",
  recipient_phone: "0602020204",
  address: "20 rue Saint-Georges, 75009 Paris",
  complete_after: today + (16 * 60 + 30) * 60,
  complete_before: today + 20 * 60 * 60,
  picked_up_at: today + 12 * 60 * 60,
  delivered_at: today + (12 * 60 + 30) * 60
  )

today_delivery_2.company = brasserie
today_delivery_2.save!

today_delivery_3 = Delivery.new(
  recipient_name: "Tristram Robert",
  recipient_phone: "0602020205",
  address: "10 rue de Ménilmontant, 75020 Paris",
  complete_after: today + (16 * 60 + 30) * 60,
  complete_before: today + 20 * 60 * 60,
    picked_up_at: today + 12 * 60 * 60,
  delivered_at: today + (12 * 60 + 30) * 60
  )

today_delivery_3.company = brasserie
today_delivery_3.save!








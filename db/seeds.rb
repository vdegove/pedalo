puts "Creating company Brasserie Tout Schuss…"
brasserie = Company.new( name: "Brasserie Tout Schuss")
brasserie.address = "9 rue Ambroise Thomas, Paris"
brasserie.contact_name = "Martoche"
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
pack1 = PackageType.create!( name: "Pack de 12 bières blondes 33 cl")
# CompanyPackageType.package_type = pack1
pack2 = PackageType.create!( name: "Pack de 12 bières ambrées 33 cl")
# CompanyPackageType.package_type = pack2
pack3 = PackageType.create!( name: "Pack de 6 bières IPA 50 cl")
# CompanyPackageType.package_type = pack3
pack4 = PackageType.create!( name: "Fut de 30 L de bière blonde")
# CompanyPackageType.package_type = pack4

puts "Creating plants package types…"
PackageType.create!(name: "Grande jardinière 80 cm × 20 cm")
PackageType.create!(name: "Pot de fleur moyen")

tomorrow = (Date.today + 1).to_time

puts "Creating a first delivery for Tout Schuss…"

laffitte_delivery = Delivery.new(
  recipient_name: "Olivier",
  recipient_phone: "0602020202",
  address: "43 Rue Laffitte, 75009 Paris",
  complete_after: tomorrow + (8 * 60 + 30) * 60,
  complete_before: tomorrow + 13 * 60 * 60
  )

laffitte_delivery.company = brasserie

casks_for_delivery = DeliveryPackage.new(
  delivery: laffitte_delivery,
  package_type: PackageType.find_by(name: "Fut de 30 L de bière blonde"),
  amount: 3)
bottles_for_delivery = DeliveryPackage.new(
  delivery: laffitte_delivery,
  package_type: PackageType.find_by(name: "Pack de 6 bières IPA 50 cl"),
  amount: 1)

laffitte_delivery.save!
casks_for_delivery.save!
bottles_for_delivery.save!







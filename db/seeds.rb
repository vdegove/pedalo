puts "Creating company Brasserie Tout Schuss…"
brasserie = Company.new( name: "Brasserie Tout Schuss")
brasserie.address = "16 rue de Sambre et Meuse, Paris"
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
PackageType.create!( name: "Pack de 12 bières blondes 33 cl")
PackageType.create!( name: "Pack de 12 bières ambrées 33 cl")
PackageType.create!( name: "Pack de 6 bières IPA 50 cl")
PackageType.create!( name: "Fut de 30 L de bière blonde")

puts "Creating plants package types…"
PackageType.create!(name: "Grande jardinière 80 cm × 20 cm")
PackageType.create!(name: "Pot de fleur moyen")


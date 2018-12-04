puts "Creating company Brasserie Tout Schuss…"
Company.create!( name: "Brasserie Tout Schuss")

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


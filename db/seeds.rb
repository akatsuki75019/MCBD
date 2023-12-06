require 'faker'

personas = [
  ["Alex", "Martin", "1985-04-13", "alexthp"],
  ["Axel", "Leveque", "1973-11-07", "axelthp"],
  ["Floriane", "Blanc", "989-04-1989", "flothp"],
  ["Nelly", "Schmitt", "1992-03-07", "nellythp"],
  ["Sam", "Pichon", "1997-07-22", "samthp"],
  ["Vincent", "Weber", "1999-09-21", "vincthp"]
]

personas.shuffle.each do |persona|
  first_name = persona[0]
  last_name = persona[1]
  birthday = persona[2]
  password = persona[3]

  email = "#{first_name.downcase}@yopmail.com"

  User.create!(
    email: email,
    password: password,
    first_name: first_name,
    last_name: last_name,
    birthday: birthday
  )
end

3.times do 
  Category.create!(
    name: ["Shonen", "Seinen", "Shojo"].sample
  )
end

10.times do
  Editor.create!(
    name: ["Kurokawa", "Ki-Oon", "Dargaud", "P’tit Glénat", "Delcourt"].sample,
    distributor: "Interforum"
  )
end

10.times do
  PriceCode.create!(
    name: ["KURO20", "KN15", "KN25", "KN30"].sample,
    price: rand(1.00..20.00)
  )
end


books = [
  ["979-1042013370", "Skeleton DoubleT01", "15", "ao_ashi.jpg", "Eiichiro Oda", "2023-01-11"],
  ["979-1032716205", "Jujutsu Kaisen T22", "25", "choujin_x_1959146.png", "Eiichiro Oda", "2023-01-04"],
  ["979-1032716076", "Frieren T11", "20", "coq_de_baston.jpg", "Eiichiro Oda", "2023-01-04"],
  ["979-1032718032", "#Drcl Midnight Children T01", "20", "db1.jpg", "Eiichiro Oda", "2023-01-25"],
  ["979-1032716496", "Valkyrie Apocalypse T18", "20", "FX__8rvaAAEmYwi.jpg", "Eiichiro Oda", "2023-01-04"],
  ["979-1032716519", "Valkyrie Apocalypse T18 - Édition Collector", "15", "kaguya-sama_-_love_is_war_26965636.jpg", "Eiichiro Oda", "2023-01-04"],
  ["979-1032716588", "Valkyrie Apocalypse - La Légende De Lü Bu T01", "15", "kaiju.jpg", "Eiichiro Oda", "2023-01-04"],
  ["979-1032716625", "Crescent Moon, Dance With The Monster T01", "15", "shonen_abyss.jpg", "Eiichiro Oda", "2023-01-25"],
  ["978-2723488525", "One Piece T01", "7", "wind_breaker.png", "Eiichiro Oda", "2023-01-25"]
]

books.shuffle.each do |book|
  isbn = book[0]
  title = book[1]
  quantity = book[2]
  image_url = book[3]
  author = book[4]
  release_date = book[5]

  Book.create!(
    isbn: isbn,
    title: title,
    author: author,
    quantity: quantity,
    release_date: release_date,
    tva: "5.5",
    image_url: image_url,
    editor_id: Editor.all.sample.id,
    price_code_id: PriceCode.all.sample.id,
    category_id: Category.all.sample.id,
  )
end
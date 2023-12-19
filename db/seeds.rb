require 'faker'

puts "Remise à zéro des modèles existants..."
Book.destroy_all
Category.destroy_all
Editor.destroy_all
Event.destroy_all
PriceCode.destroy_all
User.destroy_all


personas = [
  ["Alex", "Martin", "1985-04-13", "alexthp", "false"],
  ["Axel", "Leveque", "1973-11-07", "axelthp", "false"],
  ["Floriane", "Blanc", "989-04-1989", "flothp", "true"],
  ["Nelly", "Schmitt", "1992-03-07", "nellythp", "true"],
  ["Sam", "Pichon", "1997-07-22", "samthp", "false"],
  ["Vincent", "Weber", "1999-09-21", "vincthp", "false"],
  ["Generic-user", "Generic-user", "1999-09-21", "genericthp", "true"]
  
]

personas.shuffle.each do |persona|
  first_name = persona[0]
  last_name = persona[1]
  birthday = persona[2]
  password = persona[3]
  is_admin = persona[4]

  email = "#{first_name.downcase}@yopmail.com"

  User.create!(
    email: email,
    password: password,
    first_name: first_name,
    last_name: last_name,
    birthday: birthday,
    is_admin: is_admin
  )
end

#section categories
categories = [["Shonen"], ["Seinen"], ["Shojo"]]

categories.shuffle.each do |category|
  name = category[0]
  Category.create!( name: name )
end

#section editors
editors = [["Kurokawa"], ["Ki-Oon"], ["Dargaud"], ["P’tit Glénat"], ["Delcourt"], ["Glénat"], ["Pika"], ["Kana"], ["Kazé"], ["Taifu Comics"], ["Soleil Manga"], ["Akata"], ["Panini Manga"], ["Mangetsu"]]


editors.shuffle.each do |editor|
  name = editor[0]
  Editor.create!( name: name, distributor: "Interforum")
end

#section price
price_codes = [["GL10", "6.99"], ["GL15", "7.90"],["PK03", "7.20"], ["PK04", "7.70"],["KA01", "7.50"], ["KA02", "6.80"], ["KI05", "7.60"], ["KZ03", "7.40"], ["KZ04", "7.50"], ["DC10", "6.90"],["DC15", "7.80"]]

  price_codes.shuffle.each do |price_code|
    name = price_code[0]
    price = price_code[1]
    PriceCode.create!( name: name, price: price )
  end


# books = [
#   ["979-1042013370", "Skeleton DoubleT01", "15", "ao_ashi.jpg", "Eiichiro Oda", "2023-01-11 19:30:00 UTC"],
#   ["979-1032716205", "Jujutsu Kaisen T22", "25", "choujin_x_1959146.png", "Eiichiro Oda", "2023-01-04 19:30:00 UTC"],
#   ["979-1032716076", "Frieren T11", "20", "coq_de_baston.jpg", "Eiichiro Oda", "2023-01-04 19:30:00 UTC"],
#   ["979-1032718032", "#Drcl Midnight Children T01", "20", "db1.jpg", "Eiichiro Oda", "2023-01-25 19:30:00 UTC"],
#   ["979-1032716496", "Valkyrie Apocalypse T18", "20", "FX__8rvaAAEmYwi.jpg", "Eiichiro Oda", "2023-01-0419:30:00 UTC"],
#   ["979-1032716519", "Valkyrie Apocalypse T18 - Édition Collector", "15", "kaguya-sama_-_love_is_war_26965636.jpg", "Eiichiro Oda", "2023-01-04 19:30:00 UTC"],
#   ["979-1032716588", "Valkyrie Apocalypse - La Légende De Lü Bu T01", "15", "kaiju.jpg", "Eiichiro Oda", "2023-01-04 19:30:00 UTC"],
#   ["979-1032716625", "Crescent Moon, Dance With The Monster T01", "15", "shonen_abyss.jpg", "Eiichiro Oda", "2023-01-25 19:30:00 UTC"],
#   ["978-2723488525", "One Piece T01", "7", "wind_breaker.png", "Eiichiro Oda", "2023-01-25 19:30:00 UTC"],
#   ["979-1042013371", "Skeleton DoubleT02", "15", "ao_ashi.jpg", "Eiichiro Oda", "2023-01-12 19:30:00 UTC"],
#   ["979-1032716206", "Jujutsu Kaisen T23", "25", "choujin_x_1959146.png", "Eiichiro Oda", "2023-01-05 19:30:00 UTC"],
#   ["979-1032716077", "Frieren T12", "20", "coq_de_baston.jpg", "Eiichiro Oda", "2023-01-05 19:30:00 UTC"],
#   ["979-1032718033", "#Drcl Midnight Children T02", "20", "db1.jpg", "Eiichiro Oda", "2023-01-26 19:30:00 UTC"],
#   ["979-1032716497", "Valkyrie Apocalypse T19", "20", "FX__8rvaAAEmYwi.jpg", "Eiichiro Oda", "2023-01-05 19:30:00 UTC"],
#   ["979-1032716520", "Valkyrie Apocalypse T19 - Édition Collector", "15", "kaguya-sama_-_love_is_war_26965636.jpg", "Eiichiro Oda", "2023-01-05 19:30:00 UTC"],
#   ["979-1032716589", "Valkyrie Apocalypse - La Légende De Lü Bu T02", "15", "kaiju.jpg", "Eiichiro Oda", "2023-01-05 19:30:00 UTC"],
#   ["979-1032716626", "Crescent Moon, Dance With The Monster T02", "15", "shonen_abyss.jpg", "Eiichiro Oda", "2023-01-26 19:30:00 UTC"]
# ]

books = 
[["9791032712337"], ["9782331076824"], ["9782331079184"], ["9782331018503"], ["9782811616779"], ["9782811607494"], ["9782811649265"], ["9782811652739"], ["9782811654375"], ["9782811658120"], ["9782811660093"], ["9782811645281"], ["9782811653057"], ["9782505043515"], ["9782505043522"], ["9782505043539"], ["9782505048527"], ["9782820311450"], ["9782820311467"], ["9782820311481"], ["9782820311573"], ["9791039119177"], ["9782331036576"], ["9782331036583"], ["9782331036590"], ["9782331036606"], ["9782331036613"], ["9782331036620"], ["9782505048626"], ["9782505048633"], ["9782823854008"], ["9782823875706"], ["9782823854053"], ["9782823872774"], ["9782505112884"], ["9782505114154"], ["9782505116264"]]


books.shuffle.each do |book|
  isbn = book[0]
  # title = book[1]
  quantity = book[2]
  # image_url = book[3]
  # author = book[4]
  # release_date = book[5]

  Book.create!(
    isbn: isbn,
    price_code_id: PriceCode.all.sample.id,
    # title: title,
    # author: author,
    quantity: rand(5..20),
    # release_date: release_date,
    tva: "5.5",
    # image_url: image_url,
    # editor_id: Editor.all.sample.id,
    
    category_id: Category.all.sample.id,
  )
end

events = [
  ["La Nuit ONE PIECE", "Le manga le plus vendu de l'histoire sort son 105e volume ! Pour l'occasion, Glénat, l'éditeur de 'One Piece', lance la seconde édition de la 'Nuit One Piece', le 29 septembre prochain dans toutes les librairies partenaires. Au programme, animations et prévente du nouveau tome.", "2024-09-29", "https://res.cloudinary.com/dgsiwrjpp/image/upload/v1703004103/MCBD/onepiecenight.jpg"],
  ["Mini Conférence", "Manga, un peu.. beaucoup.. passionnément. Que vous découvrire les manges ou êtes fan au point de trouver des figurines dans chaque recoin de votre domicile, tout le monde est bienvenu", "2024-02-11", "https://res.cloudinary.com/dgsiwrjpp/image/upload/v1703003770/MCBD/naruto.png"],
  ["Initiation à l'art traditionnel du manga avec Jessie Lousteau", "L'illustratrice Jessie Lousteau vous initiera à l'art ancestrale du dessin manga. Venez découvrir autour d'une plume et d'un pinceau, la technique de l'encre de Chine dans l'univers du Manga : lignes claires, hachures et ombrages. À partir de 10 ans.", "2023-12-13", "https://res.cloudinary.com/dgsiwrjpp/image/upload/v1703004032/MCBD/art.png"],
  ["Raconte-moi une histoire Japon", "Un samedi par mois, les bibliothécaires vous proposent des lectures d’albums, d’histoires projetées et kamishibaïs. Les bibliothécaires vous lisent des haïku, des kamishibaïs et des albums pour découvrir le Japon en histoires. Suivi d’un atelier origami. Pour les 4-7 ans", "2023-12-16", "https://res.cloudinary.com/dgsiwrjpp/image/upload/v1703003770/MCBD/grande_vague.png"],
  ["Goûter des ados : spécial manga", "Tu as entre 11 et 15 ans et tu es mordu.e de manga ? Rejoins-nous pour partager tes coups de coeur ! Fais ta sélection de mangas et partage-la avec les autres lecteurs et lectrices et les bibliothécaires, nous t'attendons autour d'un goûter ! Ce sera aussi l'occasion de discuter de tes lectures dans le cadre de l'opération des Mordus du manga, qui se termine le samedi 13 janvier 2024. Tu as adoré, détesté ? Parlons-en !", "2024-01-10", "https://res.cloudinary.com/dgsiwrjpp/image/upload/v1703003770/MCBD/lunch.png"],
  ["Apéro Philo", "La soirée philo est animé par Charles et modéré par Jules. La question: 'La quête du sens peut-elle abolir l'absurde ?", "2024-02-06", "https://res.cloudinary.com/dgsiwrjpp/image/upload/v1703004032/MCBD/aperophilo.png"],
  ["Yoga du Rire", "Avec Jo et Véro, un grand moment de lâcher prise, thérapie par le rire - découverte ludique d'une oeuvre célèbre", "2024-02-07", "https://res.cloudinary.com/dgsiwrjpp/image/upload/v1703003770/MCBD/yoga.png"],
  ["Festival de la BD", "Festival International de la Bande Dessinée d'Angoulême - Site officiel du Festival qui se déroule à Angoulême du 25 au 28 janvier 2024.", "2024-02-08", "https://res.cloudinary.com/dgsiwrjpp/image/upload/v1703004032/MCBD/festivalbd.png"],
  ["Rencontre et Dédicace", "Naruto nous fait l'honneur de sa présence dans la librairie et nous présentera sa dernière tome", "2024-02-10", "https://res.cloudinary.com/dgsiwrjpp/image/upload/v1703003770/MCBD/mangalove.png"],
  ["La Nuit ONE PIECE", "Le manga le plus vendu de l'histoire sort son 105e volume ! Pour l'occasion, Glénat, l'éditeur de 'One Piece', lance la seconde édition de la 'Nuit One Piece', le 29 septembre prochain dans toutes les librairies partenaires. Au programme, animations et prévente du nouveau tome.", "2024-09-29", "https://res.cloudinary.com/dgsiwrjpp/image/upload/v1703004103/MCBD/onepiecenight.jpg"],
  ["Mini Conférence", "Manga, un peu.. beaucoup.. passionnément. Que vous découvrire les manges ou êtes fan au point de trouver des figurines dans chaque recoin de votre domicile, tout le monde est bienvenu", "2024-02-11", "https://res.cloudinary.com/dgsiwrjpp/image/upload/v1703003770/MCBD/naruto.png"],
  ["Initiation à l'art traditionnel du manga avec Jessie Lousteau", "L'illustratrice Jessie Lousteau vous initiera à l'art ancestrale du dessin manga. Venez découvrir autour d'une plume et d'un pinceau, la technique de l'encre de Chine dans l'univers du Manga : lignes claires, hachures et ombrages. À partir de 10 ans.", "2023-12-13", "https://res.cloudinary.com/dgsiwrjpp/image/upload/v1703004032/MCBD/art.png"],
  ["Raconte-moi une histoire Japon", "Un samedi par mois, les bibliothécaires vous proposent des lectures d’albums, d’histoires projetées et kamishibaïs. Les bibliothécaires vous lisent des haïku, des kamishibaïs et des albums pour découvrir le Japon en histoires. Suivi d’un atelier origami. Pour les 4-7 ans", "2023-12-16", "https://res.cloudinary.com/dgsiwrjpp/image/upload/v1703003770/MCBD/grande_vague.png"],
  ["Goûter des ados : spécial manga", "Tu as entre 11 et 15 ans et tu es mordu.e de manga ? Rejoins-nous pour partager tes coups de coeur ! Fais ta sélection de mangas et partage-la avec les autres lecteurs et lectrices et les bibliothécaires, nous t'attendons autour d'un goûter ! Ce sera aussi l'occasion de discuter de tes lectures dans le cadre de l'opération des Mordus du manga, qui se termine le samedi 13 janvier 2024. Tu as adoré, détesté ? Parlons-en !", "2024-01-10", "https://res.cloudinary.com/dgsiwrjpp/image/upload/v1703003770/MCBD/lunch.png"],
  ["Apéro Philo", "La soirée philo est animé par Charles et modéré par Jules. La question: 'La quête du sens peut-elle abolir l'absurde ?", "2024-02-06", "https://res.cloudinary.com/dgsiwrjpp/image/upload/v1703004032/MCBD/aperophilo.png"],
  ["Yoga du Rire", "Avec Jo et Véro, un grand moment de lâcher prise, thérapie par le rire - découverte ludique d'une oeuvre célèbre", "2024-02-07", "https://res.cloudinary.com/dgsiwrjpp/image/upload/v1703003770/MCBD/yoga.png"]
]

events.shuffle.each do |event|
  title = event[0]
  description = event[1]
  start_date = event[2]
  image_url = event[3]

  Event.create!(
    title: title,
    description: description,
    start_date: start_date,
    image_url: image_url
    )
end

User.find_each do |user|
  event_to_attend = Event.all.sample
  Attendance.create(user: user, event: event_to_attend)
end

puts "Seed généré avec succès 🥳"
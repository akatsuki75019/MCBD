require 'cloudinary'

if Cloudinary.config.api_key.blank?
  require './config'
end

puts 'My cloud name is: ' + Cloudinary.config.cloud_name

# Demandez combien d'images vous souhaitez télécharger
puts 'Combien d\'images voulez-vous télécharger ?'
num_images = gets.chomp.to_i

# Initialisez un tableau pour stocker les URLs des images téléchargées
image_urls = []

# Transformation à appliquer à toutes les images téléchargées
transformation = [
  { width: 1000, crop: 'scale' },
  { quality: 'auto' },
  { fetch_format: :auto }
]

# Téléchargez les images et stockez leurs URLs
num_images.times do |i|
  puts "Entrez l'URL de l'image ##{i + 1}:"
  image_url = gets.chomp

  # Appliquez la transformation et téléchargez l'image
  upload = Cloudinary::Uploader.upload(image_url,
    use_filename: true,
    unique_filename: false,
    overwrite: true,
    transformation: transformation # Appliquer la transformation
  )

  image_urls << upload['secure_url']
end

# Affichez les URLs des images téléchargées avec la transformation
puts 'URLs des images téléchargées avec la transformation :'
image_urls.each do |url|
  puts url
end

require 'cloudinary'

Cloudinary.config_from_url("cloudinary://422511497262331:NQuXkmsI1Au0z0lkJuTL5SXX_o8@dgsiwrjpp")
Cloudinary.config do |config|
  config.secure = true
end

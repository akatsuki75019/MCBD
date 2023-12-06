class UserMailer < ApplicationMailer
  default from: 'no-reply@mcbd.fr'

  def welcome_email(user)
    #Récupère l'instance pour la view
    @user = user
    @url  = 'http://mcbd.fr/login'

    mail(to: @user.email, subject: 'Bienvenue chez nous !')
  end
end

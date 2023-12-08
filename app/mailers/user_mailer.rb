class UserMailer < ApplicationMailer
  default from: "courtois.a@hotmail.com"

  def welcome_email(user)
    #Récupère l'instance pour la view
    @user = user
    @url  = 'https://mcbdapp-2089282d029d.herokuapp.com/'

    mail(to: @user.email, subject: "Bienvenue chez nous !")
  end
end

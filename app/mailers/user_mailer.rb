class UserMailer < ApplicationMailer
  default from: "mcbd.production@gmail.com"

  def welcome_email(user)
    #Récupère l'instance pour la view
    @user = user
    @url  = 'https://mcbdapp-2089282d029d.herokuapp.com/'

    mail(to: @user.email, subject: "Bienvenue chez nous !")
  end


  def order_confirmation(user)
    #Récupère l'instance pour la view
    @user = user
    @url  = 'https://mcbdapp-2089282d029d.herokuapp.com/'

    mail(to: @user.email, subject: "Merci votre achat.")
  end

end

class UserMailer < ApplicationMailer
  default from: "mcbd.production@gmail.com"

  def welcome_email(user)
    #Récupère l'instance pour la view
    @user = user
    @url  = 'https://mcbdapp-2089282d029d.herokuapp.com/'
    
    mail(to: @user.email, subject: "Bienvenue chez nous !")
  end


  def order_confirmation(order)
    #Récupère l'instance pour la view
    @user = order.user
    @order = order
    @total_price = order.total_price
    @url  = 'https://mcbdapp-2089282d029d.herokuapp.com/'

    mail(to: @user.email, subject: "Merci votre achat.")
  end

end

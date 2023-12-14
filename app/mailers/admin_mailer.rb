class AdminMailer < ApplicationMailer
  default from: "mcbd.production@gmail.com"
  

  def admin_order_confirmation(order, admin_user)
   
    @order = order
    @url  = 'https://mcbdapp-2089282d029d.herokuapp.com/'

    mail(to:admin_user.email, subject: "Une commande a été passée sur le site.")
  end
  
  
end

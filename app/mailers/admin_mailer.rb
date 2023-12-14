class AdminMailer < ApplicationMailer
  default from: "mcbd.production@gmail.com"
  

  def admin_order_confirmation(order, admin_user, name_to_display)
   
    @order = order
    @url  = 'https://mcbdapp-2089282d029d.herokuapp.com/'
    @name_to_display = name_to_display
    @total_price = order.total_price
    @ordered_books = order.books

    mail(to:admin_user.email, subject: "Une commande a été passée sur le site.")
  end
  
  
end

class AdminMailer < ApplicationMailer
  default from: "mcbd.production@gmail.com"
  

  def admin_order_confirmation(order, admin_user, name_to_display, total_price)
   
    @order = order
    @url  = 'https://mcbdapp-2089282d029d.herokuapp.com/'
    @name_to_display = name_to_display
    puts "****Total Price NELLY****: #{total_price}" # Ajoutez cette ligne pour le débogage


    mail(to:admin_user.email, subject: "Une commande a été passée sur le site.")
  end
  
  
end

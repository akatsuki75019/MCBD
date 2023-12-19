class UserMailer < ApplicationMailer
  default from: "mcbd.production@gmail.com"

  def welcome_email(user)
    @user = user
    @url  = 'https://mcbdapp-2089282d029d.herokuapp.com/'
    
    mail(to: @user.email, subject: "Bienvenue chez nous !")
  end


  def order_confirmation(order)
    @user = order.user
    @order = order
    @url  = 'https://mcbdapp-2089282d029d.herokuapp.com/'
    @books = order.joint_table_order_books.map(&:book)
    if order.total_price != 0
      mail(to: @user.email, subject: "Merci votre achat.")
    end
  end

end

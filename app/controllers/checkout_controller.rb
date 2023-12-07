class CheckoutController < ApplicationController
  def create
    @total = params[:total].to_d
    @user_id = params[:user_id]
    @joint_table_cart_books = current_user.cart.joint_table_cart_books.includes(:book)
    total_price = @joint_table_cart_books.sum { |joint_table_cart_book| joint_table_cart_book.book.price_code.price }
  
    joint_table_cart_book_ids = @joint_table_cart_books.pluck(:id)
  

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [
        {
          price_data: {
            currency: 'eur',
            unit_amount: (@total*100).to_i,
            product_data: {
              name: 'Rails Stripe Checkout',
            },
          },
          quantity: 1
        },
      ],
      metadata: {
        joint_table_cart_book_ids: joint_table_cart_book_ids.join(','),
        user_id: @user_id
       
      },
      mode: 'payment',
      customer_email: current_user.email, 
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: checkout_cancel_url
    )
    redirect_to @session.url, allow_other_host: true
  
  end

  def success

    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    joint_table_cart_book_ids = @session.metadata.joint_table_cart_book_ids.split(',').map(&:to_i)
   

    #Création d'une nouvelle instance dans la BDD Order (voir dans le model Order)
    Order.create_order_with_books(current_user, joint_table_cart_book_ids)



    # Effacer les articles du panier après la commande
      current_user.cart.joint_table_cart_books.destroy_all
  end


  def cancel
  end

end
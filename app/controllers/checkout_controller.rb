class CheckoutController < ApplicationController
  def create
    @user_id = params[:user_id]
    return if current_user != User.find(@user_id)

    @joint_table_cart_books = current_user.cart.joint_table_cart_books.includes(:book)
    total_price = @joint_table_cart_books.sum { |joint_table_cart_book| joint_table_cart_book.book.price_code.price }
    joint_table_cart_book_ids = @joint_table_cart_books.pluck(:id)
    @total = current_user.cart.joint_table_cart_books.sum { |joint_table_cart_book| joint_table_cart_book.book.price_code.price * joint_table_cart_book.quantity }
  
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
        user_id: @user_id,
        checkout_type: 'cart_checkout',
       
      },
      mode: 'payment',
      customer_email: current_user.email, 
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: checkout_cancel_url
    )
    puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
    puts "Session: #{@session.inspect}"
    puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
    redirect_to @session.url, allow_other_host: true
  
  end

  def express_checkout
    puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
    puts "Params: #{params.inspect}"
    puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"

    @user_id = params[:user_id]
    @book = Book.find_by(id: params[:book_id])
    @quantity = params[:quantity].to_i
    @total = params[:total].present? ? params[:total].to_d : @book.price_code.price #test : s'assurer que si le paramètre "total" est présent, vous l'utilisez, sinon, vous utilisez le prix du livre comme total par défaut

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [
        {
          price_data: {
            currency: 'eur',
            unit_amount: (@total*100).to_i,
            product_data: {
              name: @book.title,
            },
          },
          quantity: 1
        },
      ],

      metadata: {
        user_id: @user_id,
        checkout_type: 'express_checkout',
        book_id: @book.id,
      },

      mode: 'payment',
      customer_email: current_user.email, 
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: checkout_cancel_url
    )
    puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
    puts "Session: #{@session.inspect}"
    puts "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$"
    redirect_to @session.url, allow_other_host: true
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
    checkout_type = @session.metadata['checkout_type']
    @total = @session.amount_total / 100.0
    @order = order

    if checkout_type == 'cart_checkout' #cas du paiement via le panier
      joint_table_cart_book_ids = @session.metadata.joint_table_cart_book_ids.split(',').map(&:to_i)
      @joint_table_cart_books = JointTableCartBook.where(id: joint_table_cart_book_ids).includes(:book)

    #Création d'une nouvelle instance dans la BDD Order (voir dans le model Order)
       @order = Order.create_order_with_books(current_user, joint_table_cart_book_ids)

    #Gérer la màj des quantités après un paiement stripe:
      joint_table_cart_book_ids.each do |joint_table_cart_book_id| #conversion des identifiants des JointTableCartBook, on les diviseàchaque virgule, on converti en entiers
        joint_table_cart_book = JointTableCartBook.find(joint_table_cart_book_id) #on chercheun id specifique
      # Mettre à jour la quantité en stock du livre
        book = joint_table_cart_book.book 
        new_stock_quantity = book.quantity - joint_table_cart_book.quantity #new stock = quantité actuelle du livre - qté commandée
        book.update(quantity: new_stock_quantity) #mise à jour de la qté en stock
      end

    # Effacer les articles du panier après la commande
      current_user.cart.joint_table_cart_books.destroy_all


    else # gestion pour l'achat express (pas de panier)
      book_id = @session.metadata['book_id']
      user_id = @session.metadata.user_id
      total_price = @session.amount_total / 100.0

       # Récupérer le livre associé à l'achat express
      book = Book.find_by(id: book_id)

      #Création d'une nouvelle instance dans la BDD Order (voir dans le model Order)
      @order = Order.create_order_for_express_purchase(current_user, book, total_price)

      #Gérer la màj des quantités après un paiement stripe:
      book.update_stock_quantity(1)
    end
  end

  def cancel
  end

end
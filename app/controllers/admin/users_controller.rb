module Admin
  class UsersController < Admin::ApplicationController

    def destroy
      user = User.find(params[:id])

      if user.cart.present?
        if user.cart.joint_table_cart_books.any?
          user.cart.joint_table_cart_books.destroy_all
        end
        user.cart.destroy
      end

      # Attribuer les commandes à l'utilisateur générique
      if user.orders.any?
        generic_user = User.find_by(email: 'generic-user@yopmail.com')
        user.orders.update_all(user_id: generic_user.id)
      end

      # Supprimer l'utilisateur 
      user.destroy

      redirect_to admin_users_path, notice: 'Utilisateur supprimé avec succès.'
    end
  end
end

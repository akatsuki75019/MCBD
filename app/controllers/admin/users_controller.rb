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

      #réattribuer les attendances aux events
      if user.attendances.any?
        generic_user = User.find_by(email: 'generic-user@yopmail.com')
        user.attendances.update_all(user_id: generic_user.id)
      end

      # Supprimer l'utilisateur 
      user.destroy
    end

    # Overwrite any of the RESTful controller actions to implement custom behavior
    # For example, you may want to send an email after a foo is updated.
    #
    # def update
    #   super
    #   send_foo_updated_email(requested_resource)
    # end
    # Override this method to specify custom lookup behavior.
    # This will be used to set the resource for the `show`, `edit`, and `update`
    # actions.
    #
    # def find_resource(param)
    #   Foo.find_by!(slug: param)
    # end
    # Override this if you have certain roles that require a subset
    # this will be used to set the records shown on the `index` action.
    #
    # def scoped_resource
    #   if current_user.super_admin?
    #     resource_class
    #   else
    #     resource_class.with_less_stuff
    #   end
    # end
    # Override `resource_params` if you want to transform the submitted
    # data before it's persisted. For example, the following would turn all
    # empty values into nil values. It uses other APIs such as `resource_class`
    # and `dashboard`:
    #
    # def resource_params
    #   params.require(resource_class.model_name.param_key).
    #     permit(dashboard.permitted_attributes(action_name)).
    #     transform_values { |value| value == "" ? nil : value }
    # end
    # See https://administrate-demo.herokuapp.com/customizing_controller_actions
    # for more information
  end
end

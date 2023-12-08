module Admin
  class ApplicationController < Administrate::ApplicationController
    before_action :authenticate_admin

    def authenticate_admin
      redirect_to '/', alert: 'Accès non autorisé !' unless current_user && access_whitelist
    end

    def access_whitelist
      current_user.is_admin?
    end
  end
end
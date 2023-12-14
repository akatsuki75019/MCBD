class UsersController < ApplicationController
  def show
    @user = current_user
    if current_user == nil
      redirect_to new_user_session_path
    else
      @user = current_user
      @recent_purchases = @user.orders.includes(:books).order(created_at: :desc).limit(4)
    end
  end

  def check_user
    @user = User.find(params[:id])
    if current_user.id != @user.id
      redirect_to root_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: 'Votre compte a été créé avec succès !'
    else
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    @user.update(user_params)
    
  
    if @user.errors.empty?
      redirect_to root_path, notice: 'Profil mis à jour avec succès.'
    else
      render :edit
    end
  end


  def destroy
  end

  private 

  def user_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :birthday)
  end
end

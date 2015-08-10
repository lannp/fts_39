class UsersController < ApplicationController
  before_action :init_user, only: [:show, :edit, :update]

  def edit  
  end

  def show
  end

  def update
    if @user.update_attributes user_params
      sign_in @user, bypass: true
      flash[:success] = t "edit_user.profile_update"
      redirect_to @user
    else
      flash[:danger] = t "edit_user.update_failed"
      render :edit

    end
  end

  private
  def init_user
    @user = User.find params[:id]
  end 

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation, :avatar
  end
end

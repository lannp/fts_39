class UsersController < ApplicationController
  load_and_authorize_resource

  def show
  end

  def edit  
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
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation, :avatar
  end
end

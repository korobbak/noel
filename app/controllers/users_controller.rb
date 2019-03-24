class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = t "users.create.success"
    else
      flash[:danger] = t "users.create.danger"
    end
    redirect_to request.referer
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :account, :password, :password_confirmation, :user_role_id)
  end
end

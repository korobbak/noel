class Admin::UsersController < ApplicationController
  before_action :logged_in_admin, only: %i(index create new)
  layout "admin"

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Tạo thành công"
    else
      flash[:danger] = "Tạo thất bại"
    end
    redirect_to request.referer
  end

  def index
    @users = User.where("user_role_id=2").page(params[:page]).per 5
  end

  def destroy
    @user = User.find_by id: params[:id]
    @user.destroy
    redirect_to request.referer
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :account, :password, :password_confirmation, :user_role_id)
  end

  def logged_in_admin
    return false if logged_in?
    redirect_to login_url
  end
end

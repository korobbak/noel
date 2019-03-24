class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by account: params[:session][:account]
    if user&.authenticate(params[:session][:password])
      login_success user
    else
      login_fail
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to request.referer
  end

  def login_success user
    log_in user
    if params[:session][:remember_me] == "1"
      check_login user
    elsif params[:session][:remember_me] == "0"
      check_login user
    else
      forget user
      redirect_to new_path
    end
  end

  def check_login user
    if user.user_role.role == "admin"
      remember user
      redirect_to admin_index_path
    elsif user.user_role.role == "user"
      remember user
      redirect_to request.referer
    elsif user.user_role.role == "post"
      remember user
      redirect_to post_index_path
    end
  end

  def login_fail
    redirect_to request.referer
  end
end

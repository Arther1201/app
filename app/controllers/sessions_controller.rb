class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in(user)
      if params[:remember_me]
        cookies.permanent.signed[:user_id] = user.id
      end
      flash[:notice] = 'ログインしました'
      redirect_to patients_path
    else
      flash.now[:alert] = 'メールアドレスまたはパスワードが無効です'
      render 'new'
    end
  end

  def destroy
    log_out
    flash[:notice] = 'ログアウトしました'
    redirect_to root_path
  end

  def guest_login
    # ゲストユーザーを検索または作成
    user = User.find_by(email: 'guest@example.com') || User.create_guest_user
    log_in(user)
    redirect_to patients_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  private

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end

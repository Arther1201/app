class PasswordResetsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user
      user.generate_password_reset_token!  # トークン生成メソッドをユーザーモデルに追加
      PasswordMailer.with(user: user).reset_password_email.deliver_now
      redirect_to login_path, notice: 'パスワードリセットの手順がメールで送信されました。'
    else
      flash.now[:alert] = 'メールアドレスが見つかりませんでした。'
      render :new
    end
  end

  def edit
    @user = User.find_by(password_reset_token: params[:id])
    Rails.logger.debug "Token received: #{params[:id]}" # デバッグ用
    unless @user
      redirect_to new_password_reset_path, alert: '無効なパスワードリセットリンクです。'
    end
  end

  def update
    @user = User.find_by(password_reset_token: params[:id])
    if @user && @user.update(password_reset_params)
      @user.clear_password_reset_token!  # トークンを無効化するメソッドをユーザーモデルに追加します
      redirect_to login_path, notice: 'パスワードがリセットされました。'
    else
      flash.now[:alert] = 'パスワードのリセットに失敗しました。'
      render :edit
    end
  end

  private

  def password_reset_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end

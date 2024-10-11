class PasswordMailer < ApplicationMailer
    def reset_password_email
      @user = params[:user]
      @url = edit_password_reset_url(@user.password_reset_token, host: 'dental-tecnical-note.com')
      mail(to: @user.email, subject: 'パスワードリセットのご案内')
    end
  end
  
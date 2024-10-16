class PasswordMailer < ApplicationMailer
    def reset_password_email
      @user = params[:user]
      @url = edit_password_reset_url(@user.password_reset_token, host: 'dental-tecnical-note.com')
      Rails.logger.debug "Password reset URL: #{@url}" # デバッグ用
      mail(to: @user.email, subject: 'パスワードリセットのご案内')
    end
end
  
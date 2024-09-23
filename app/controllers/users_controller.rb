class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to patients_path, notice: 'ユーザー登録が完了しました。'
    else
      flash[:alert] = @user.errors.full_messages.join(", ")
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :department_id)
  end
end

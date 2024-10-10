class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params.except(:employee_keyword)) # employee_keywordを除外して新規ユーザーを作成

    @user.employee_keyword = params[:user][:employee_keyword] # 仮想属性としてemployee_keywordを設定
    
    if User.exists?(email: @user.email)
      flash[:alert] = "このメールアドレスはすでに登録されています。"
      render :new
    elsif @user.save
      log_in(@user)
      redirect_to patients_path, notice: 'ユーザー登録が完了しました。'
    else
      flash[:alert] = @user.errors.full_messages.join(", ")
      render 'new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :department_id, :employee_keyword)
  end
end

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @items = @user.items.uniq
    @count_want = @uesr.want_items.count
  end

  def new
    @user = User.new
  end

  def create
     @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

end

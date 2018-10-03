class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def index
    @users = search params[:search], User, "code", "name"
    @user = User.new
  end

  def show
    @subjects = @user.subjects.paginate page: params[:page], per_page:
      Settings.per_page.long
  end

  def edit; end

  def destroy
    if @user.destroy
      flash[:success] = t "flash_delete"
    else
      flash[:danger] = t "flash_delete_fail"
    end
    redirect_to users_url
  end

  def set_user
    @user = User.find_by id: params[:id]
  end
end

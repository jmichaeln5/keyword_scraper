class UsersController < ApplicationController
  before_action :authenticate_user!
  # before_action :checkyoself

  def index
    # => #redering places#index
    @user = current_user
    @sites = Site.where(user_id: @user).order("created_at DESC")
  end

  def edit
  end

  def show
    # => #redering places#index
    @user = current_user
    @sites = Site.where(user_id: @user).order("created_at DESC")
  end

private
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation )
  end

  # def checkyoself
  #   redirect_to(root_url) unless current_user
  # end

end

class UsersController < ApplicationController

  skip_before_action :authenticate_user, only: [:create, :new]
  before_action :find_user, only: [:show, :update, :destroy]

  def index
    @users = User.all
    respond_to do |format|
      format.html { render :index }
    end
  end

  def show
    @user
  end

  def new
    User.new
  end

  def signin
    User.new
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      @token = JsonWebToken.encode(user_id: @user.id)
      @time = Time.now + 24.hours.to_i
      render json: { token: @token, exp: @time.strftime("%m-%d-%Y %H:%M"),
                     user_name: @user.user_name }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to '/', notice: 'User was successfully created.' }
      else
        format.html { render :new, alert: @user.errors.full_messages }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render :update }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    end
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :user_name, :email, :password, :password_confirmation)
  end

end

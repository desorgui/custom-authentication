class UsersController < ApplicationController

  skip_before_action :authenticate_user, only: [:new, :create, :login, :signin, :social_login]
  before_action :find_user, only: [:show, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user
  end

  def social_login
    user_info = request.env['omniauth.auth']
    uid =  user_info.uid
    email = user_info.info['email']
    name = user_info.info['name']
    avatar = user_info.info['image']
    user_name = user_info.info['nickname']

    user = User.find_by(email: email)
   
       if user.nil?
         # If the user doesn't exist, create a new user
         user = User.create!(
           user_name: email,
           email: email,
           name: name,
           password: SecureRandom.hex(8)
         )
       end
       p user_name
       @token = ApplicationController.encode(user_id: user.id)
       cookies.signed[:jwt] = { value: @token, httponly: true, expires: 24.hours.from_now }
       redirect_to root_path, notice: 'Signed in!'
  end

  def new
    User.new
  end

  def signin
    User.new
  end

  def login
    @user = User.find_by(user_name: params[:user][:user_name])
    respond_to do |format|
      if @user&.authenticate(params[:user][:password])
        @token = ApplicationController.encode(user_id: @user.id)
        cookies.signed[:jwt] = { value: @token, httponly: true, expires: 24.hours.from_now }
        @time = Time.now + 24.hours.to_i
        format.html { redirect_to '/', notice: 'User was successfully logged in.' }
      else 
        render json: { error: 'unauthorized' }, status: :unauthorized
      end
    end
  end

  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to '/', notice: 'User was successfully created.' }
      else
        format.html { redirect_to '/users/new', alert: @user.errors.full_messages }
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

  def login_params
    params.require(:user).permit(:user_name, :password)
  end

  def user_params
    params.require(:user).permit(:name, :user_name, :email, :password, :password_confirmation)
  end

end

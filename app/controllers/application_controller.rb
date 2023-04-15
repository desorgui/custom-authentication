class ApplicationController < ActionController::Base
  include JwtToken

  before_action :authenticate_user

  private

  def authenticate_user
    # header = request.headers['Authorization']
    # header = header.split.last if header
    token = cookies.signed[:jwt]
    begin
      decoded = ApplicationController.decode(token)
      current_user = User.find(decoded[:user_id])
      p current_user
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :unauthorized
    end
  end
end

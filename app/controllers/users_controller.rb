class UsersController < ApplicationController
  # Create a new user
  def new
    user = User.create!(user_params)
    render json: user, status: :created
  end

  # Handle login
  def login
    user = User.find_by_email(params[:email])
    if user != nil
      if user.valid_password?(params[:password])
        token = JsonWebToken.generate(user.id)
        render json: {token: token}, status: :ok
      else
        render json: {error: "Invalid Password!"}, status: :unauthorized
      end
    else
      render json: {error: "Unknown User!"}, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:email, :password)
  end
end

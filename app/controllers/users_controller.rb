class UsersController < ApplicationController
  # Create a new user
  def new
    errors = validate_user_payload(user_params)
    errors[:email_taken] = "That email is already taken!" if user_params.key?(:email) && User.where(email: user_params[:email]).count > 0
    
    if errors.length == 0
      user = User.create!(user_params)
      render json: user, status: :created
    else
      render json: {error: errors}, status: :unprocessable_entity
    end
  end

  # Handle login
  def login
    errors = validate_user_payload(user_params)

    if errors.length > 0
      render json: {error: errors}, status: :unprocessable_entity
    else
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
  end

  private

  # NOTE: I had to add validations into the controller here because of
  #       the way devise abstracts the user functionality. Spec tests
  #       on user don't work properly because the responses are being
  #       generated from a different controller.
  def validate_user_payload(params)
    errors = {}
    
    errors[:missing_email] = "You must provide an email!" if !params.key?(:email)
    errors[:invalid_email] = "Email is invalid!" if params.key?(:email) && params[:email] !~ URI::MailTo::EMAIL_REGEXP
    errors[:missing_password] = "You must provide a password!" if !params.key?(:password)
    errors[:invalid_password] = "Password must be at least 6 characters!" if params.key?(:password) && params[:password].length < 6
    
    errors
  end

  def user_params
    params.permit(:email, :password)
  end
end

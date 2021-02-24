class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # These are the default enabled settings for Devise User,
  # I am disabling them for API mode
  #devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :validatable

  # This must be included for the password checking 
  # that devise does -gabbott
  devise :database_authenticatable

  validates :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  validates_length_of :password, minimum: 6, maximum: 18

end

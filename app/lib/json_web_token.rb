# app/lib/json_web_token.rb
require 'net/http'
require 'uri'

class JsonWebToken
  # extract the userID from the claims
  def self.get_userid(headers)
    if headers['Authorization'].present?
      token = headers['Authorization'].split(' ').last

      JWT.decode token, Rails.application.credentials.jwt[:secret], true, { algorithm: 'HS256' }
    end
  end

  # verify the token
  def self.verify(token)
    JWT.decode token, Rails.application.credentials.jwt[:secret], true, { algorithm: 'HS256' }
  end

  # generate a new JWT for the user
  def self.generate(id)
    # expires in 4 hours
    exp = Time.now.to_i + 4 * 3600

    payload = { id: id, exp: exp }

    JWT.encode payload, Rails.application.credentials.jwt[:secret], 'HS256'
  end
end

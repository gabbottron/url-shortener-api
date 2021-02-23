# Load the Rails application.
require_relative 'application'

# Check for required credentials before loading!
credentials_ok = true
if Rails.application.credentials.jwt == nil
  credentials_ok = false
else
  if !Rails.application.credentials.jwt.key?(:secret)
    credentials_ok = false
  else
    if Rails.application.credentials.jwt[:secret].length < 1
      credentials_ok = false
    end
  end
end

if !credentials_ok
  raise("Missing required credentials to start! Check documentation!!")
end

# Initialize the Rails application.
Rails.application.initialize!

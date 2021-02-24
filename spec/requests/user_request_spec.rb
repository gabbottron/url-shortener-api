require 'rails_helper'

RSpec.describe "Users", type: :request do
  # A valid new user payload
  valid_new_user = { :email => "a@b1.com", :password => "derp123" }

  # An invalid new user payload (password too short)
  invalid_new_user_short_password = { :email => "a@b2.com", :password => "derp" }

  # An invalid new user payload (bad email)
  invalid_new_user_bad_email = { :email => "a@", :password => "derp123" }

  # An invalid new user payload (password missing)
  invalid_new_user_missing_password = { :email => "a@b2.com" }

  # An invalid new user payload (missing email)
  invalid_new_user_missing_email = { :password => "derp123" }

  ## BEGIN User create tests ------------------------------------
  it "creates user with valid params" do
    post "/users/new", :params => valid_new_user
    expect(response).to have_http_status(:created)
  end

  it "creates user with invalid password (too short)" do
    post "/users/new", :params => invalid_new_user_short_password
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it "creates user with invalid email" do
    post "/users/new", :params => invalid_new_user_bad_email
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it "creates user with missing password" do
    post "/users/new", :params => invalid_new_user_missing_password
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it "creates user with missing email" do
    post "/users/new", :params => invalid_new_user_missing_email
    expect(response).to have_http_status(:unprocessable_entity)
  end

  it "tries to create a user with duplicate email" do
    post "/users/new", :params => valid_new_user
    expect(response).to have_http_status(:created)
    post "/users/new", :params => valid_new_user
    expect(response).to have_http_status(:unprocessable_entity)
  end

  ## BEGIN User login tests  ------------------------------------
  it "logs in user with valid params" do
    # first create
    post "/users/new", :params => valid_new_user
    expect(response).to have_http_status(:created)
    # now login
    post "/users/login", :params => valid_new_user
    expect(response).to have_http_status(:success)
    # check for token in response
    resp = JSON.parse(response.body)
    expect(resp.key?("token")).to be(true)
  end
end

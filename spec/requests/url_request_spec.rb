require 'rails_helper'

RSpec.describe "Urls", type: :request do
  # A valid new user payload
  valid_new_user = { :email => "a@b1.com", :password => "derp123" }

  # A valid URL payload
  valid_new_url = { :original_url => "http://www.google.com" }

  it "creates url with valid params but no JWT" do
    post "/urls", :params => valid_new_url
    expect(response).to have_http_status(:unauthorized)
  end

  it "creates url with valid params" do
    # first create
    post "/users/new", :params => valid_new_user
    expect(response).to have_http_status(:created)
    # now login
    post "/users/login", :params => valid_new_user
    expect(response).to have_http_status(:success)
    # now attempt to save a URL with a valid JWT
    resp = JSON.parse(response.body)
    post "/urls", :params => valid_new_url, :headers =>  {'Authorization' => "bearer #{resp["token"]}"}
    expect(response).to have_http_status(:created)
  end
end

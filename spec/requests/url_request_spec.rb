require 'rails_helper'

RSpec.describe "Urls", type: :request do
  # A valid new user payload
  valid_new_user = { :email => "a@b1.com", :password => "derp123" }

  # A valid URL payload (minimal)
  valid_new_url = { :original_url => "http://www.google.com" }

  # A valid URL payload (slug specified)
  valid_new_url_slug_specified = { :original_url => "http://www.google.com", :slug => "googz" }

  # Invalid URL payload (missing original_url)
  invalid_new_url_missing_original_url = {}

  # Invalid URL payload (missing protocol in original_url)
  invalid_new_url_missing_protocol_in_original_url = { :original_url => "www.google.com" }

  it "creates url with valid params but no JWT" do
    post "/urls", :params => valid_new_url
    expect(response).to have_http_status(:unauthorized)
  end

  it "creates url with valid params (minimal)" do
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
    # now examine the body
    resp = JSON.parse(response.body)
    # slug should be present (generated)
    expect(resp.key?("slug")).to be(true)
    # original URL should be present
    expect(resp.key?("original_url")).to be(true)
    # original URL should be equal to URL specified in payload
    expect(resp["original_url"]).to eq(valid_new_url[:original_url])
    # active should be present
    expect(resp.key?("active")).to be(true)
    # active should be true (default)
    expect(resp["active"]).to be(true)
    # decode token for userID
    claims = JsonWebToken.get_userid(request.headers)
    # user_id should be present
    expect(resp.key?("user_id")).to be(true)
    # user_id should match the id in the JWT
    expect(resp["user_id"]).to eq(claims[0]["id"].to_i)
  end

  it "creates url with valid params (slug specified)" do
    # first create
    post "/users/new", :params => valid_new_user
    expect(response).to have_http_status(:created)
    # now login
    post "/users/login", :params => valid_new_user
    expect(response).to have_http_status(:success)
    # now attempt to save a URL with a valid JWT
    resp = JSON.parse(response.body)
    post "/urls", :params => valid_new_url_slug_specified, :headers =>  {'Authorization' => "bearer #{resp["token"]}"}
    expect(response).to have_http_status(:created)
    # now examine the body
    resp = JSON.parse(response.body)
    # slug should be present (specified)
    expect(resp.key?("slug")).to be(true)
    # slug should be equal to slug in payload
    expect(resp["slug"]).to eq(valid_new_url_slug_specified[:slug])
  end

  it "creates url with invalid params (no original_url)" do
    # first create
    post "/users/new", :params => valid_new_user
    expect(response).to have_http_status(:created)
    # now login
    post "/users/login", :params => valid_new_user
    expect(response).to have_http_status(:success)
    # now attempt to save a URL with a valid JWT
    resp = JSON.parse(response.body)
    did_rescue = false
    begin
      post "/urls", :params => invalid_new_url_missing_original_url, :headers =>  {'Authorization' => "bearer #{resp["token"]}"}
    rescue ActiveRecord::RecordInvalid => invalid
      did_rescue = true
    end
    # Post should trigger active record validation failure
    expect(did_rescue).to be(true)
  end

  it "creates url with invalid params (original_url missing protocol)" do
    # first create
    post "/users/new", :params => valid_new_user
    expect(response).to have_http_status(:created)
    # now login
    post "/users/login", :params => valid_new_user
    expect(response).to have_http_status(:success)
    # now attempt to save a URL with a valid JWT
    resp = JSON.parse(response.body)
    did_rescue = false
    begin
      post "/urls", :params => invalid_new_url_missing_protocol_in_original_url, :headers =>  {'Authorization' => "bearer #{resp["token"]}"}
    rescue ActiveRecord::RecordInvalid => invalid
      did_rescue = true
    end
    # Post should trigger active record validation failure
    expect(did_rescue).to be(true)
  end
end

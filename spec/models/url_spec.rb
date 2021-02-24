require 'rails_helper'

RSpec.describe Url, type: :model do
  it "is invalid with no attributes set" do
    expect(Url.new).not_to be_valid
  end

  it "is invalid with original_url missing protocol" do
    expect(Url.new(original_url: "www.aol.com")).not_to be_valid
  end

  it "is invalid with original_url as valid URL but no user_id" do
    expect(Url.new(original_url: "http://www.aol.com")).not_to be_valid
  end

  it "is valid with valid original_url and user" do
    u = User.create!(email: "a@b.com", password: "abc123")
    expect(Url.new(user_id: u.id, original_url: "http://www.aol.com")).to be_valid
  end
end

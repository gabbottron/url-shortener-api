require 'rails_helper'

RSpec.describe User, type: :model do
  it "is invalid with no attributes set" do
    expect(User.new).not_to be_valid
  end

  it "is invalid with no email set" do
    expect(User.new(password: "abc123")).not_to be_valid
  end

  it "is invalid with no password set" do
    expect(User.new(email: "a@b.com")).not_to be_valid
  end

  it "is invalid with password shorter than 6 characters" do
    expect(User.new(email: "a@b.com", password: "abc")).not_to be_valid
  end

  it "is valid with valid email and password" do
    expect(User.new(email: "a@b.com", password: "abc123")).to be_valid
  end

  it "is invalid when email is already taken" do
    User.create!(email: "a@b.com", password: "abc123")
    expect(User.new(email: "a@b.com", password: "abc123")).not_to be_valid
  end
end

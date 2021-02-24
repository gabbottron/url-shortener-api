require 'rails_helper'

RSpec.describe User, type: :model do
  it "is invalid with missing password attribute" do
    expect(User.new).not_to be_valid
  end  
end

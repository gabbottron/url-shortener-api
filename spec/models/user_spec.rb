require 'rails_helper'

# TODO: Update documentation to put secrets in for test environment
#       and also add documentation on how to use rspec

RSpec.describe User, type: :model do
  it "is invalid with missing password attribute" do
    # TODO: Update requirements on the user model for this!
    expect(User.new).not_to be_valid
  end
end

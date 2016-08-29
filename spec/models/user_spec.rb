require 'rails_helper'

RSpec.describe User do
  it "should not save if email already exists."
  it "should not save if first_name field is blank." do
   user = User.new(first_name: '')
   expect(user).to be_invalid
  end
  it "should contain a valid email"
end

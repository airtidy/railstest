require 'rails_helper'

RSpec.describe User, type: :model do
  it "has valid factory" do
    expect(FactoryGirl.create(:user)).to be_valid
  end
end

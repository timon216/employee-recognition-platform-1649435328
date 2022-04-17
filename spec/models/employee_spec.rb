require 'rails_helper'

RSpec.describe Employee, type: :model do
  it 'has a valid factory' do
    expect(build(:employee)).to be_valid
  end

  it 'is not valid without an email address' do
    expect(build(:employee, email: '')).not_to be_valid
  end

  it 'is not valid with the invalid email address' do
    expect(build(:employee, email: 'abc123')).not_to be_valid
  end

  it 'is not valid without a password' do
    expect(build(:employee, password: '')).not_to be_valid
  end
end

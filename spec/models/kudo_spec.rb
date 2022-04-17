require 'rails_helper'

RSpec.describe Kudo, type: :model do
  it 'has a valid factory' do
    expect(build(:kudo)).to be_valid
  end

  it 'is not valid without the title' do
    expect(build(:kudo, title: '')).not_to be_valid
  end

  it 'is not valid without the content' do
    expect(build(:kudo, content: '')).not_to be_valid
  end
end

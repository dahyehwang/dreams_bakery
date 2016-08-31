require 'rails_helper'

RSpec.describe Message, type: :model do
  it 'requires content' do
    content = Message.new
    content.valid?
    expect(content.errors[:content].any?).to eq(true)
  end
end

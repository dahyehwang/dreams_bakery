require 'rails_helper'

RSpec.describe User, type: :model do
	it "requires first_name" do
		user = User.new(first_name: '')
		user.valid?
		expect(user.errors[:first_name].any?).to eq(true)
	end
	it "requires last_name" do
		user = User.new(last_name: '')
		user.valid?
		expect(user.errors[:last_name].any?).to eq(true)
	end
	it "requires at least 2 characters for first_name" do
		user = User.new(first_name: 'a')
		user.valid?
		expect(user.errors[:first_name].any?).to eq(true)
	end
	it "requires at least 2 characters for last_name" do
		user = User.new(last_name: 'a')
		user.valid?
		expect(user.errors[:last_name].any?).to eq(true)
	end

	it "requires nickname to be unique" do
		user1 = User.create(
			first_name: "Jane",
			last_name: "Doe",
			nickname: "Jane",
			email: "janethebest@codingdojo.com",
			password: "password",
			password_confirmation: "password"
		)
	user2 = User.new(
			first_name: "Jane",
			last_name: "Smith",
			nickname: "Jane",
			email: "jane@codingdojo.com",
			password: "password",
			password_confirmation: "password"
		)
		user2.valid?
		expect(user2.errors[:nickname].first).to eq("has already been taken")
	end
	it "allows nickname to be blank" do
		user = User.create(
			first_name: "Jane",
			last_name: "Doe",
			nickname: "",
			email: "janethebest@codingdojo.com",
			password: "password",
			password_confirmation: "password"
		)
		user.valid?
		expect(user.errors[:nickname].any?).to eq(false)
	end
	it 'requires an email' do
  	user = User.new(email: '')
  	user.valid?
  	expect(user.errors[:email].any?).to eq(true)
  end
  it 'accepts properly formatted email' do
  	emails = ['steph@dubs.com', 'steph.curry@dubs.com']
  	emails.each do |email|
  		user = User.new(email: email)
  		user.valid?
  		expect(user.errors[:email].any?).to eq(false)
  	end
  end
  it 'rejects improperly formatted email' do
  	emails = %w[@ user@ @example.com]
  	emails.each do |email|
  		user = User.new(email: email)
  		user.valid?
  		expect(user.errors[:email].any?).to eq(true)
  	end
  end
  it 'requires a unique, case insensitive email address' do
  	user1 = User.create(first_name: 'steph', last_name: 'curry', email: 'steph@dubs.com', password: 'password', password_confirmation: 'password')
  	user2 = User.new(email: user1.email.upcase)
  	user2.valid?
  	expect(user2.errors[:email].first).to eq("has already been taken")
  end
	it 'requires a password' do
  	user = User.new(password: '')
  	user.valid?
  	expect(user.errors[:password].any?).to eq(true)
  end
  it 'requires the password to match the password confirmation' do
  	user = User.new(password: 'password', password_confirmation: 'not password')
  	user.valid?
  	expect(user.errors[:password_confirmation].first).to eq("doesn't match Password")
  end
  it 'automatically encrypts the password into the password_digest attribute' do
  	user = User.create(first_name:'steph', last_name:'curry', email: 'steph@dubs.com', password: 'password', password_confirmation: 'password')
  	expect(user.password_digest.present?).to eq(true)
  end
  describe 'relationships' do
    it 'has many messages' do
      user = User.create(first_name:'steph', last_name:'curry', email: 'steph@dubs.com', password: 'password', password_confirmation: 'password')
      message1 = user.messages.create(content: 'message 1')
      message2 = user.messages.create(content: 'message 2')
      expect(user.messages).to include(message1)
      expect(user.messages).to include(message2)
    end
    it 'has many likes' do
      user = User.create(first_name:'steph', last_name:'curry', email: 'steph@dubs.com', password: 'password', password_confirmation: 'password')
      message1 = user.messages.create(content: 'Oops')
      message2 = user.messages.create(content: 'I did it again')
      like1 = Like.create(user: user, message: message1)
      like2 = Like.create(user: user, message: message2)
      expect(user.likes).to include(like1)
      expect(user.likes).to include(like2)
    end
  end
end

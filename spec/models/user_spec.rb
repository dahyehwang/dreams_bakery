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
	# it "should not save if email already exists." do
	# User.create(
	# first_name: "Jane",
	# last_name: "Doe",
	# nickname: "Doe",
	# email: "janethebest@codingdojo.com",
	# password: "password",
	# password_confirmation: "password"
	# )
	# user = User.new(
	# first_name: "Jane",
	# last_name: "Smith",
	# nickname: "Smith",
	# email: "janethebest@codingdojo.com",
	# password: "password",
	# password_confirmation: "password"
	# )
	# expect(user).to be_invalid
	# end

	# it "should contain a valid email" do
	# user = User.new(
	# first_name: 'Roald',
	# last_name: 'Dahl',
	# email: 'roalddahl'
	# )
	# expect(user).to be_invalid
	# end
end

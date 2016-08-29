# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
@user1 = User.create([{ first_name: 'Valentyna', last_name: 'Gorbachenko', nickname: 'Valie', email: 'valie@codingdojo.com', password: 'password', password_confirmation: 'password' }])
@user2 = User.create([{ first_name: 'Sang', last_name: 'Yun', nickname: 'Sang316', email: 'sang316@gmail.com', password: 'password', password_confirmation: 'password' }])
@user3 = User.create([{ first_name: 'Carlos', last_name:'Chen', nickname: 'Charie', email:'charie86@gmail.com', password: 'password', password_confirmation: 'password' }])
@user4 = User.create([{ first_name: 'Dahye', last_name: 'Hwang', nickname: 'Grace', email: 'grace@codingdojo.com', password: 'password', password_confirmation: 'password' }])

@parent1 = Parent.create([{}])
messages = Message.create([{ content: 'Dojo rocks!!!', user: @user1 }])
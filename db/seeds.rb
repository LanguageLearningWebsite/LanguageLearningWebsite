# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
AdminUser.create!(email: 'cultureintegratedchinese@gmail.com', password: 'tcucultureintegratedchinese', password_confirmation: 'tcucultureintegratedchinese')
@course = Course.create!(name: 'test course', content: 'test content')
Lesson.create!(course: @course, title: 'test lesson', note: 'test note')

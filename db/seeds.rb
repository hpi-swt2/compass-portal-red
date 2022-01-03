# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Points of Interest
PointOfInterest.create(:point => Point.create(:x => 13.131646, :y => 52.393869), :description => 'This is Mr. Net, a landmark of the HPI.', :name => 'Mr. Net')
PointOfInterest.create(:point => Point.create(:x => 13.132215, :y => 52.393793), :description => 'This is Lake HPI.', :name => 'Lake HPI')
PointOfInterest.create(:point => Point.create(:x => 13.133757, :y => 52.394414), :description => 'This area is used for freetime activities by HPI students.', :name => 'Meadow')
PointOfInterest.create(:point => Point.create(:x => 13.13130, :y => 52.39335), :description => 'This is a nice place to eat.', :name => 'Ulf''s Cafe')

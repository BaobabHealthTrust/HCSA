# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)puts 'loading services'

puts 'loading services names'
servicelist = ["OPD","Martenity","Theatre","Eye","Dental","Skin Clinic","OB/Gyn",	 "Casualties",
				 "Medical","Pediatrics","Family Planning","Surgical","Orthropedics","Radiology"]
  			 (servicelist).each do |name|
  			 s_type = Service.new()
 			 s_type.name = name
 			 s_type.save
	      end


puts 'loading satisfaction level'
	s = ["FULLY SATISFIED","SATISFIED","ATLEAST SATISFIED","A BIT SATISFIED","NOT SATISFIED"]
  			 (s).each do |name|
  			 satlevel = Satlevel.new()
 			 satlevel.name = name
 			 satlevel.save
	      end

puts 'loading concerns'
 	concerns = ["No Medicine","No security","Harsh Attitude Nurses","Unhygienic rooms","Unhygienic bedings","Delay treatment",
			"Careless Nurses"
			]
  			 (concerns).each do |name|
  			 conce = Concern.new()
 			 conce.name = name
 			 conce.save
	      end



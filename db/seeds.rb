# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Mayor.create(:name => 'Daley', :city => cities.first)puts 'loading services'

servicelist = ["OPD","Martenity","Theatre","Eye","Dental","Skin Clinic","OB/Gyn",	 "Casualties",
				 "Medical","Pediatrics","Family Planning","Surgical","Orthropedics","Radiology"]
  			 (servicelist).each do |name|
  			 s_type = Service.new()
 			 s_type.name = name
 			 s_type.save
	      end

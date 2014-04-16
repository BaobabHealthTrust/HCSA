class Concern < ActiveRecord::Base
	
	set_table_name  :concerns
	set_primary_key :concern_id
 	has_many 	:vote_concerns
	has_many 	:service_concerns
end

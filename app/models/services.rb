class Services < ActiveRecord::Base

	set_table_name  :services
	set_primary_key :service_id
	has_many 	:votes
	has_many 	:concerns
end

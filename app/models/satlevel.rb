class Satlevel < ActiveRecord::Base

	set_table_name	:satlevels
	set_primary_key	:satlevel_id
	has_many :votes
end

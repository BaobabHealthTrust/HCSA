class Comment < ActiveRecord::Base
	validates :comment, :presence => true

	set_table_name 	:comments
	set_primary_key :comment_id
	belongs_to 	:service

end

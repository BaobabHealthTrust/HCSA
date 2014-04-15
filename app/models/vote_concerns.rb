require "ruby gems"
require "composite_primary_keys"

class VoteConcerns < ActiveRecord::Base
	
	set_table_name    :vote_concerns
	set_primary_keys  :concern_id, :vote_id
	belongs_to 	  :vote
	belongs_to 	  :concern
end

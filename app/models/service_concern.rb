require 'rubygems'
require 'composite_primary_keys'

class ServiceConcern < ActiveRecord::Base

	set_table_name    :service_concerns
	set_primary_keys  :concern_id, :service_id
	belongs_to :service
	belongs_to :concern

end

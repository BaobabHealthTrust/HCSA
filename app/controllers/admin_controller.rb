class AdminController < ApplicationController
  def index
	render :layout => 'admin'
  end


	def third
		 @service =Service.all.delete_if{|service|service.name.blank?}
	
	end

	def forth
		@votes = Vote.all
		@satlevel = Satlevel.all
		@concerns = Concern.all
	end

end

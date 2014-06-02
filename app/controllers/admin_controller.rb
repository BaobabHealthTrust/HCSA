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

	
	def listservice
		@service = Service.all
	end

	def listconcerns
		@concerns = Concern.all
	end

	def addConcerns

	concerns = Concern.new(params[:add_concern])
    	

  	 	 if concerns.save
		  flash[:notice] = "Concern added."
   		   redirect_to :action=>"listconcerns"
    		end

	
	end

	def delconcern
 	@concern = Concern.find(params[:id]) 
	end 

	def destroyConcern 
	Concern.find(params[:id]).destroy 
	flash[:notice] = "Concern deleted." 
	redirect_to(:action => 'listconcerns') 
	end 

	def addService

	service = Service.new(params[:add_service])
    	

  	 	 if service.save
		  flash[:notice] = "service added."
   		   redirect_to :action=>"listservice"
    		end

	
	end


	def delservice
 	@service = Service.find(params[:id]) 
	end 

	def destroyService 
	Service.find(params[:id]).destroy 
	flash[:notice] = "service deleted." 
	redirect_to(:action => 'listservice') 
	end 


	def editconcern
	 @concern = Concern.find(params[:id]) 
	end 
	
	def updateConcern 
		@concern = Concern.find(params[:id]) 

		if @concern.update_attributes(params[:concern]) 
		flash[:notice] = "Concern updated." 
		redirect_to(:action =>'listconcerns', :id => @concern.id) 
		else 
		render('editconcern') 
		end
	end


	def editservice
	 @service = Service.find(params[:id]) 
	end 
	
	def updateService 
		@service = Service.find(params[:id]) 
		if @service.update_attributes(params[:service]) 
		flash[:notice] = "Service updated." 
		redirect_to(:action =>'listservice', :id => @service.id) 
		else 
		render('editservice') 
		end
	end
	 
end

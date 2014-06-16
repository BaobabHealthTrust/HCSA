class AdminController < ApplicationController
  def index
	render :layout => 'admin'
  end


	def third
		 @service =Service.all.delete_if{|service|service.name.blank?}
	
	end

	def forth

		@service_selected = params[:service]


		@votes = Vote.all
		@satlevel = Satlevel.all
	 

	
		@result = Satlevel.joins(:votes)
		@result2 = @result.find_by_sql("select name, date, count(*) as 'total_votes' from satlevels left join votes on
 						satlevels.satlevel_id = votes.satlevel_id group by satlevels.satlevel_id ")
		
		
		@concern = Concern.joins(:vote_concerns)
		@concern2 = @concern.find_by_sql(" select name, count(*) as 'total' from vote_concerns join concerns on 
						   concerns.concern_id = vote_concerns.concern_id group by concerns.concern_id")

		
		@result = Satlevel.select('satlevels.name, votes.date, count(votes.*) as total_votes')
                                  .joins(:votes)
                                  .group('satlevels.name, votes.date')
                                  .order('satlevels.name, votes.date')		
		

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

<<<<<<< HEAD
	def addService
=======
	def editconcern
    @concern = Concern.find(params[:id])
  end
  
  def update
    # Find object using form parameters
    @concern = Concern.find(params[:id])
    # Update the object
    if @concern.update_attributes(params[:concern])
      # If update succeeds, redirect to the list action
      redirect_to(:action => 'listconcerns', :id => @concern.id)
    else
      # If save fails, redisplay the form so user can fix problems
      render('editconcern')
    end
  end
    

>>>>>>> 8df718f1432cdbc32dae6884212bfdbeb34b8eac

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




 

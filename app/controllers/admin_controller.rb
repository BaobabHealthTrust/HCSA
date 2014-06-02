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

	def destroy 
	Concern.find(params[:id]).destroy 
	flash[:notice] = "Concern deleted." 
	redirect_to(:action => 'listconcerns') 
	end 

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
    


	def login

	end

end

class VotesController < ApplicationController
	
	
	
	def index
		render :layout => 'barcode'
	end

	def authenticate
	
	
	    hash= Digest::SHA1.hexdigest(params[:barcode])
       
     	    validate_time = Vote.where(["client_id =? AND created_at >= ?", hash, Time.now - 2.hour])

   	 	  if !(validate_time.blank?)

			   flash[:notice] = "you have already voted.Thank you"
			   redirect_to :controller=>"vote", :action=>"index"
	    		 else
	      		 	redirect_to :controller=>"votes", :action=>"serviceselect", :client_id => hash
      
		 end
	
	end
	
	
	def serviceselect

	   @service =Service.all.delete_if{|service|service.name.blank?}

	end

	
	def checksat
	
		#raise params.to_yaml
		hash_id = params[:client_id]
		@service_selected = params[:service]
		#raise @service_selected.to_yaml
		@sat = Satlevel.all.delete_if{|sat|sat.name.blank?}
		
	 end
	
	def assesslevel
	
		#raise params.to_yaml
		if ((params[:satlevel])== "FULLY SATISFIED" || (params[:satlevel])== "SATISFIED")
        	
   
		redirect_to :controller=>"votes", :action=>"save_vote"#, :client_id => client_id, 
           	#:service_type => service_type,:response => params[:answers]
		else 
			redirect_to :controller=>"votes", :action=>"concerns"#, :client_id => client_id, 
            		#:service_type => service_type,:vote_type => params[:answers]
		end
	end
	
	
	def concerns
	 
        #raise params.to_yaml
	
	@concerns = Concern.all
		
	end
	
	
	def save_vote
	raise params.to_yaml
	end
	
	

end

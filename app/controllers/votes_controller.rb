class VotesController < ApplicationController
	
	def index
		render :layout => 'barcode'
	end

	def authenticate
	
	    hash= Digest::SHA1.hexdigest(params[:barcode])
       
     	    validate_time = Vote.where(["client_id =? AND created_at >= ?", hash, Time.now - 2.hour])

   	 	  if !(validate_time.blank?)

			   flash[:notice] = "you have already voted.Thank you"
			   redirect_to :controller=>"votes", :action=>"index"
	    		 else
	      		 redirect_to :controller=>"votes", :action=>"serviceselect", :client_id => hash
      
		 end
	
	end
	
	
	def serviceselect

	   @service =Service.all.delete_if{|service|service.name.blank?}

	end

	
	def checksat
	
		@hash_id = params[:client_id]
		@service_selected = params[:service]
		@sat = Satlevel.all.delete_if{|sat|sat.name.blank?}
		
	 end
	
	def assesslevel
		client_id = params[:client_id]
		selected_service = params[:service_sel]
		
		if ((params[:satlevel])== "FULLY SATISFIED" || (params[:satlevel])== "SATISFIED")
        	
   			redirect_to :controller=>"votes", :action=>"save_vote", :client_id => client_id, 
           		:service_choice => selected_service,:response => params[:satlevel]
		   else 
			redirect_to :controller=>"votes", :action=>"concerns", :client_id => client_id, 
            		:service_choice => selected_service,:response => params[:satlevel]
		end
	end
	
	
	def concerns
	    	@service = params[:service_choice]
      		@concerns = Concern.all
		
	end
	
	
	def save_vote
	
		vote = Vote.new
       		vote.client_id   = params[:client_id] 
		vote.satlevel_id = Satlevel.find_by_name(params[:response]).id
		#raise params.to_yaml
		vote.service_id  = Service.find_by_name(params[:service_choice]).id
		
		if vote.save
			
				concern= params[:concerns]
				concern.each do |f|
				vote_concern 	        = VoteConcern.new
				vote_concern.vote_id    = Vote.last.id
				vote_concern.concern_id = Concern.find_by_name(f).id
				vote_concern.save
			
			   	end if !(params[:concern].nil?)
				redirect_to :controller=>"votes", :action=>"comment", :service => params[:service_choice]
			
		end
         		
	end 

	def comment

		$service = params[:service]

	end
	
	def save_comment

		serv = $service
		if !(params[:comment].nil?) 
			
			new_comment = Comment.new
			new_comment.service_id = Service.find_by_name(serv).id
			new_comment.comment =  params[:comment]	
			new_comment.save
			
	 		redirect_to :controller=>"votes", :action=>"index"
	       	else
			redirect_to :controller=>"votes", :action=>"index"

        	end
	end
	

end

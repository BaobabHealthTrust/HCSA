class VotesController < ApplicationController
	
	def index
		render :layout => 'barcode'
		

	end

	def authenticate
	
	    $hash= Digest::SHA1.hexdigest(params[:barcode])
       
     	    validate_time = Vote.where(["client_id =? AND created_at >= ?", $hash, Time.now - 2.hour])

   	 	  if !(validate_time.blank?)

			   flash[:notice] = "you have already voted.Thank you"
			   redirect_to :controller=>"votes", :action=>"index"
	    		 else
	      		 redirect_to :controller=>"votes", :action=>"language_select", :client_id => $hash
      
		 end
	
	end

	def language_select

	#raise params.to_yaml

	end
	
	
	def serviceselect
		#raise $hash.to_yaml
	   services =Service.all
	   @row_1 = services[0..2] || Hash.new
	  	@row_2 = services[3..5] || Hash.new
	  	@row_3 = services[6..8] || Hash.new
	  	

	  	@rows = [@row_1, @row_2, @row_3]

		if Service.count > 8
  		@nav = "MORE SERVICES "
	else
		@nav = ""
  	end
  end

  def more
  	@nav = "<< MORE SERVICES"
  	@page = "serviceselect"

  	services = Service.all
  	@row_1 = services[9..11] || Hash.new
  	@row_2 = services[12..14] || Hash.new
  	@row_3 = services[15..17] || Hash.new
  	

  	@rows = [@row_1, @row_2, @row_3]
	
  	@services = services[9..17]
  	render('serviceselect')
  end



	
	def checksat
		#raise $hash.to_yaml
		@hash_id = params[:client_id]
		$service_selected = Service.find(params[:id]).name

		sat = Satlevel.all.delete_if{|sat|sat.name.blank?}
		
		@row_1 = sat[0..1] || Hash.new
	  	@row_2 = sat[2..2] || Hash.new
	  	@row_3 = sat[3..4] || Hash.new
	  	

	  	@rows = [@row_1, @row_2, @row_3]
		
	 end
	
	def assesslevel
		#raise $hash.to_yaml
		#raise params.to_yaml
		#raise $service_selected.to_yaml
		client_id = params[:client_id]
		selected_service = params[:service_sel]
		satlevel=Satlevel.find_by_satlevel_id(params[:id]).name
		#raise satlevel.to_yaml
		
		if (satlevel== "FULLY SATISFIED" || satlevel== "SATISFIED")
        	
   			redirect_to :controller=>"votes", :action=>"save_vote", :client_id => client_id, 
           		:service_choice => selected_service,:response => satlevel
		   else 
			redirect_to :controller=>"votes", :action=>"concerns", :client_id => client_id, 
            		:service_choice => selected_service,:response => satlevel
		end
	end
	
	
	def concerns
		#raise $hash.to_yaml
		#raise params.to_yaml
		#raise $service_selected.to_yaml
		
	    	@service = params[:service_choice]
      		@concerns = Concern.all
		
	end
	
	
	def save_vote

		#raise $hash.to_yaml
		#raise params.to_yaml
		#raise $service_selected.to_yaml
	
		vote = Vote.new
       		vote.client_id   = $hash 
		vote.satlevel_id = Satlevel.find_by_name(params[:response]).id
		vote.service_id  = Service.find_by_name($service_selected).id
		
		if vote.save
			
				
			if !(params[:concerns].nil?)
	
				concern= params[:concerns]
				concern.each do |f|
				vote_concern 	        = VoteConcern.new
				vote_concern.vote_id    = Vote.last.id
				vote_concern.concern_id = Concern.find_by_name(f).id
				vote_concern.save
				end
			end 
				redirect_to :controller=>"votes", :action=>"comment", :service => $service_selected
	       end 
			
        end 

	def comment

		$service = params[:service]

	end
	
	def save_comment
		#raise $service_selected.to_yaml

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

class AdminController < ApplicationController
 
  def index

	 	
		@service_selected = params[:service]	
		@start_date =  Date.today
	 	@end_date = Date.today
		 
		@result = Satlevel.joins(:votes)
		@result2 = @result.find_by_sql("select name, count(*) as 'total_votes'
						from satlevels left join votes on satlevels.satlevel_id = votes.satlevel_id 
						where votes.created_at >='#@start_date'
   					        and votes.created_at <= date_add('#@end_date',INTERVAL 1 DAY)
						group by satlevels.satlevel_id ")

		@votes = @result.find_by_sql("select count(*) as 'total' from votes
					      where created_at >='#@start_date'
					      and created_at <= date_add('#@end_date',INTERVAL 1 DAY) ")
		
		@concern = Concern.joins(:vote_concerns)
		@concern2 = @concern.find_by_sql("select concerns.name as 'cname', count(*) as 'total', services.name as 'sname'
						  from vote_concerns 
						  join concerns on concerns.concern_id = vote_concerns.concern_id 
						  join votes on votes.vote_id = vote_concerns.vote_id 
                                   		  join services on services.service_id = votes.service_id
						  where votes.created_at >='#@start_date'
       					          and votes.created_at <= date_add('#@end_date',INTERVAL 1 DAY)
						  group by concerns.concern_id")

		@service = Service.joins(:votes)
		@service2= @service.find_by_sql("select name
						from votes join services on services.service_id = votes.vote_id")

		@satisfied = @result.find_by_sql("select count(*) as 'satisfied' from votes
						  where (satlevel_id =1 OR satlevel_id =2)
						  and votes.created_at >='#@start_date'
					          and votes.created_at <= date_add('#@end_date',INTERVAL 1 DAY)")

		@unsatisfied =@result.find_by_sql("select count(*) as 'unsatisfied' from votes 
						   where (satlevel_id = 3 OR satlevel_id =4 OR satlevel_id =5)
						   and votes.created_at >='#@start_date'
					           and votes.created_at <= date_add('#@end_date',INTERVAL 1 DAY)")
	
		@fully_satisfied =@result.find_by_sql("select name, count(*) as 'fully_satisfied' from votes left join satlevels on 							   satlevels.satlevel_id  = votes.satlevel_id
						   where (satlevels.satlevel_id = 1)
						   and votes.created_at >='#@start_date'
					           and votes.created_at <= date_add('#@end_date',INTERVAL 1 DAY)")

		@satisfied1 =@result.find_by_sql("select name, count(*) as 'satisfied' from votes left join satlevels on 							   satlevels.satlevel_id  = votes.satlevel_id
						   where (satlevels.satlevel_id = 2)
						   and votes.created_at >='#@start_date'
					           and votes.created_at <= date_add('#@end_date',INTERVAL 1 DAY)")

		@at_lsatisfied =@result.find_by_sql("select name, count(*) as 'level3' from votes left join satlevels on 							   satlevels.satlevel_id  = votes.satlevel_id
						   where (satlevels.satlevel_id = 3)
						   and votes.created_at >='#@start_date'
					           and votes.created_at <= date_add('#@end_date',INTERVAL 1 DAY)")

		@abit_satisfied =@result.find_by_sql("select name, count(*) as 'level4' from votes left join satlevels on 							   satlevels.satlevel_id  = votes.satlevel_id
						   where (satlevels.satlevel_id = 4)
						   and votes.created_at >='#@start_date'
					           and votes.created_at <= date_add('#@end_date',INTERVAL 1 DAY)")
		
		@unsatisfied1 =@result.find_by_sql("select name, count(*) as 'level5' from votes left join satlevels on 					           satlevels.satlevel_id  = votes.satlevel_id
						   where (satlevels.satlevel_id = 5)
						   and votes.created_at >='#@start_date'
					           and votes.created_at <= date_add('#@end_date',INTERVAL 1 DAY)")
		
		
		@fully_satisfied.each do |all|
		@full_s = all.fully_satisfied
		@name1 = all.name
		end

		@satisfied1.each do |all|
		@sastis = all.satisfied
		@name2 = all.name
		end

		@at_lsatisfied.each do |all|
		@atleast = all.level3
		@name3 = all.name
		end

		@abit_satisfied.each do |all|
		@abit = all.level4
		@name4 = all.name
		end

		@unsatisfied1.each do |all|
		@notsatis = all.level5
		@name5 = all.name
		end
	
		@collection = [@full_s, @sastis, @atleast, @abit, @notsatis]
		@largest = @collection.max		

		@votes.each do |all|
		@prints = all.total*1.0
		end

		@satisfied.each do |positive| 
		@prints1 = positive.satisfied
		end

		@unsatisfied.each do |negative|
		@prints2 = negative.unsatisfied
		end

		if @prints ==0
		@percentage1=0
 		@percentage2=0
		else
		@percentage1 = ((@prints1/@prints).round(2))*100
		@percentage2 = ((@prints2/@prints).round(2))*100
		end		

		 

  end

	def comments
		@result = Comment.joins(:services) 
		@result2 =@result.find_by_sql("select name, comment , comments.created_at as 'time', comment_id
						from comments join services on comments.service_id = services.service_id")

	end

	
	def delcomment
 	@comment = Comment.find(params[:id]) 
	end 

	def destroyComment 
	Comment.find(params[:id]).destroy 
	flash[:notice] = "Concern deleted." 
	redirect_to(:action => 'comments') 
	end 
 
 end

 
 

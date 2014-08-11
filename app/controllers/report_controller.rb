class ReportController < ApplicationController

	  layout 'admin'

	def specify_dates_general
		 @service =Service.all.delete_if{|service|service.name.blank?}
	end

	def specify_details
		 @service =Service.all.delete_if{|service|service.name.blank?}
	end
	
       def process_report
		#rails params.to_yaml
	    start_date = params[:start_date].to_date.strftime("%Y-%m-%d")
	    end_date = params[:end_date].to_date.strftime("%Y-%m-%d")

	    case params[:report_type]
	    when "General report"
	      redirect_to :action => 'general_report', :start_date => start_date, :end_date => end_date
	    when "Departmental report"
	      service = params[:service]
	      redirect_to :action => 'service_report', :service => service, :start_date => start_date, :end_date => end_date
	   end 
       end



	

	def general_report	
		@service_selected = params[:service]	
		@start_date = params[:start_date].to_date.strftime("%Y-%m-%d")
	 	@end_date = params[:end_date].to_date.strftime("%Y-%m-%d")
	
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
		@concern2 = @concern.find_by_sql("select name, count(*) as 'total' 
						  from vote_concerns join concerns on concerns.concern_id = vote_concerns.concern_id 
						  join votes on votes.vote_id= vote_concerns.vote_id 
						  where votes.created_at >='#@start_date'
       					          and votes.created_at <= date_add('#@end_date',INTERVAL 1 DAY)
						  group by concerns.concern_id")
		
		@satisfied = @result.find_by_sql("select count(*) as 'satisfied' from votes
						  where (satlevel_id =1 OR satlevel_id =2)
						  and votes.created_at >='#@start_date'
					          and votes.created_at <= date_add('#@end_date',INTERVAL 1 DAY)")

		@unsatisfied =@result.find_by_sql("select count(*) as 'unsatisfied' from votes 
						   where (satlevel_id = 3 OR satlevel_id =4 OR satlevel_id =5)
						   and votes.created_at >='#@start_date'
					           and votes.created_at <= date_add('#@end_date',INTERVAL 1 DAY)")

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

		require 'rubygems'
                require 'google_chart'

    		# Pie Chart
    		GoogleChart::PieChart.new('320x200', "Pie Chart",false) do |pc|
      		pc.data "satisfied", @prints1
      		pc.data "unsatisfied", @prints2
      		#pc.data "Peach", 30
      		#pc.data "Orange", 60
      		puts "\nPie Chart"
      		@graph1 = pc.to_url
 
    		end	
	   render :layout => 'report_layout'		
	end

	def service_report		
		@service_selected = params[:service]	
		@start_date = params[:start_date].to_date.strftime("%Y-%m-%d")
	 	@end_date = params[:end_date].to_date.strftime("%Y-%m-%d")
		
		@service = Service.find_by_name(params[:service]) 
		@id = @service.service_id 
	 	
		@result = Satlevel.joins(:votes)
		@result2 = @result.find_by_sql("select name, count(*) as 'total_votes' 
						from satlevels left join votes 
						on satlevels.satlevel_id = votes.satlevel_id 
						where votes.service_id = '#@id' 
						and votes.created_at >='#@start_date'
   					        and votes.created_at <= date_add('#@end_date',INTERVAL 1 DAY)
						group by satlevels.satlevel_id 
						")

		@votes = @result.find_by_sql("select count(*) as 'total' from votes 
					      where votes.service_id = '#@id' 
					      and created_at >='#@start_date'
					      and created_at <= date_add('#@end_date',INTERVAL 1 DAY) 
					      ")

		@concern = Concern.joins(:vote_concerns).joins(:votes)
		@concern2 = @concern.find_by_sql("select name, count(*) as 'total' 
						  from vote_concerns 
						  join concerns on concerns.concern_id = vote_concerns.concern_id
						  join votes on votes.vote_id= vote_concerns.vote_id 
						  where votes.service_id = '#@id' 
						  and votes.created_at >='#@start_date'
					          and votes.created_at <= date_add('#@end_date',INTERVAL 1 DAY) 
						  group by concerns.concern_id")


		@satisfied = @result.find_by_sql("select count(*) as 'satisfied' from votes
						  where (satlevel_id =1 OR satlevel_id =2)
						  and votes.service_id = '#@id'
						  and votes.created_at >='#@start_date'
					          and votes.created_at <= date_add('#@end_date',INTERVAL 1 DAY)")

		@unsatisfied =@result.find_by_sql("select count(*) as 'unsatisfied' from votes 
						   where (satlevel_id = 3 OR satlevel_id =4 OR satlevel_id =5)
						   and votes.service_id = '#@id'
						   and votes.created_at >='#@start_date'
					           and votes.created_at <= date_add('#@end_date',INTERVAL 1 DAY)")

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

		require 'rubygems'
                require 'google_chart'

    		# Pie Chart
    		GoogleChart::PieChart.new('320x200', "Pie Chart",false) do |pc|
      		pc.data "satisfied", @prints1
      		pc.data "unsatisfied", @prints2
      		#pc. "Peach", 30
      		#pc.data "Orange", 60
      		puts "\nPie Chart"
      		@graph2 = pc.to_url
 
    		end	 
		render :layout => 'report_layout'
	end
end

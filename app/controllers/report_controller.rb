class ReportController < ApplicationController

	  layout 'admin'

	def specify_dates2
		 @service =Service.all.delete_if{|service|service.name.blank?}
	end


	def specify_dates
		 @service =Service.all.delete_if{|service|service.name.blank?}
	end



	def make_deptReport
		
		@service_selected = params[:service]	
		@start_date = params[:start_date]
	 	@end_date = params[:end_date]
	 
		
		@service = Service.find_by_name(params[:service]) 
		@id = @service.service_id 

			 	
		@result = Satlevel.joins(:votes)
		@result2 = @result.find_by_sql("select name, date, count(*) as 'total_votes' from satlevels left join votes on
 						satlevels.satlevel_id = votes.satlevel_id where votes.service_id = '#@id'  group by 							satlevels.satlevel_id ")

		@votes = @result.find_by_sql("select count(*) as 'total' from votes where votes.service_id = '#@id'")
		
		
		@concern = Concern.joins(:vote_concerns).joins(:votes)
		@concern2 = @concern.find_by_sql("select name, count(*) as 'total' from vote_concerns join concerns on concerns.concern_id = 							  vote_concerns.concern_id join votes on votes.vote_id= vote_concerns.vote_id where 							  votes.service_id = '#@id' group by concerns.concern_id")

				 	
	end
end

class ReportController < ApplicationController

	  layout 'admin'


	def specify_dates
		 @service =Service.all.delete_if{|service|service.name.blank?}
	end

	def make_report
		@votes = Vote.all
		@satlevel = Satlevel.all
	 

	
		@result = Satlevel.joins(:votes)
		@result2 = @result.find_by_sql("select name, date, count(*) as 'total_votes' from satlevels left join votes on
 						satlevels.satlevel_id = votes.satlevel_id group by satlevels.satlevel_id ")
		@votes1 = @result.find_by_sql("select count(*) as 'total' from votes")
		
		
		@concern = Concern.joins(:vote_concerns)
		@concern2 = @concern.find_by_sql(" select name, count(*) as 'total' from vote_concerns join concerns on 
						   concerns.concern_id = vote_concerns.concern_id group by concerns.concern_id")

		
		@result = Satlevel.select('satlevels.name, votes.date, count(votes.*) as total_votes')
                                  .joins(:votes)
                                  .group('satlevels.name, votes.date')
                                  .order('satlevels.name, votes.date')		
		
	end

  

end

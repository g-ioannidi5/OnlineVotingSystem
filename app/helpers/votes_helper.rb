module VotesHelper
	def polls_for_select
  		Poll.where("poll_date   >= ? &&", Date.today)
	end
end
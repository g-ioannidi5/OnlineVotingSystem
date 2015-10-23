module PollsHelper
	def options_for_select
		[@access_code.code]
	end

	def options_for_lecturer_select
		[@access_code.lecturer]
	end
end

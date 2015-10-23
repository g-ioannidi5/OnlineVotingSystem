module AccessCodesHelper

	def codes_for_select
		generate = SecureRandom.urlsafe_base64(32) 
 		generate2 = SecureRandom.urlsafe_base64(32)
 		generate3 = SecureRandom.urlsafe_base64(32)
 		generate4 = SecureRandom.urlsafe_base64(32)
 		generate5 = SecureRandom.urlsafe_base64(32)
		[generate,generate2,generate3,generate4,generate5]
	end
end
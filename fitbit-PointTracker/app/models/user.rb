class User < ActiveRecord::Base
	has_many :authorizations

	def self.create_from_hash!(hash)
	 	 #client ||= Fitgem::Client.new(
		#		:consumer_key => '17e009f76e454acda410d3dbeb59d047',
		#		:consumer_secret => '1db1d74a7ecb4e97aa426fa42126edd1',
		#		:token => auth.token,
		#		:secret => auth.secret,
		#		:user_id => auth.uid,
		#		:ssl => true
		#	)
		#userinfo = client.user_info['user']
		#create(:name => userinfo['fullName'])
		create(:name => hash['uid']+hash['provider'])
	end
end
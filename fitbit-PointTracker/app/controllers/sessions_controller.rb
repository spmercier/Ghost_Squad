class SessionsController < ApplicationController


 def new
 end



	def create

	end

	def failure
	
	end
	def index
		auth = request.env['omniauth.auth']
		unless @auth = Authorization.find_from_hash(auth)
			# Create a new user or add an auth to existing user, depending on
			# whether there is already a user signed in.
			@auth = Authorization.create_from_hash(auth)
		end
		# Log the authorizing user in.
		self.current_user = @auth.user
		@activities = get_activities(@auth)
		@steps1000 = false
		@steps5000 = false
		@steps10000 = false
		@points = 0
		@steps = 0;
		@steps += @activities['summary']['steps'].to_i
	
		if @steps>1000
			@steps1000 = true
			@points += 1000
		end
		if @steps>5000
			@steps5000 = true
			@points += 5000
		end
		if @steps>10000
			@steps10000 = true
			@points += 10000	
		end
		
		
		
	end
	
	def about 
	end
	
	def profile
		@username = "Patrick Hutfless"
		@profilePic = 'http://www.fitbit.com/images/profile/defaultProfile_150_male.gif';
	end


	def connect(auth)
		@client ||= Fitgem::Client.new(
			:consumer_key => '17e009f76e454acda410d3dbeb59d047',
			:consumer_secret => '1db1d74a7ecb4e97aa426fa42126edd1',
			:token => auth.token,
			:secret => auth.secret,
			:user_id => auth.uid,
			:ssl => true
		)
		return @client
	end 
private
	def get_activities(auth)
		@client = self.connect(auth)
		@activities = @client.activities_on_date('today')
		return @activities
	end
	def get_userInfo(auth)
		@client = self.connect(auth)
		@userinfo = @client.user_info['user']
		return @userinfo
	end
end

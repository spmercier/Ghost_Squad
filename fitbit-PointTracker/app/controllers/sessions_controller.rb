class SessionsController < ApplicationController
@@pic =''
@@GlobalAuth
	 def new
	 end
 
	def create
		auth = request.env['omniauth.auth']
		
		unless @auth = Authorization.find_from_hash(auth)
			# Create a new user or add an auth to existing user, depending on
			# whether there is already a user signed in.
			@auth = Authorization.create_from_hash(auth)
			
			
		end
		@@GlobalAuth ||= @auth
		redirect_to "/sessions/index"
	end

	def failure
	
	end
	def index
		@taskstandings = true
		# Log the authorizing user in.
		auth = @@GlobalAuth
		info = get_userInfo(auth)

		self.current_user = auth.user
		activities = get_activities(auth)
		steps1000 = false
		steps5000 = false
		steps10000 = false
		pointsum = 0
		steps = 0
		steps += activities['summary']['steps'].to_i
	
		if steps>1000
			steps1000 = true
			pointsum += 1000
		end
		if steps>5000
			steps5000 = true
			pointsum += 5000
		end
		if steps>10000
			steps10000 = true
			pointsum += 10000	
		end

		@user = User.find_by(name: info['fullName']).update_attribute(:points, pointsum)
		@points = pointsum

		@users = User.order(points: :desc).limit(10)
		@count = 1
	end
	
	def about 
	end
	
	def profile
		info = get_userInfo(@@GlobalAuth)
		@pic = info['avatar']
		@name = info['fullName']
		@user = User.find_by(name: info['fullName'])
		@points = @user.points

		users = User.order(points: :desc)
		count = 1
		@standing = 20

		users.each do |user|
			if user.name == @name
 				@standing = count
			end

			count = count + 1
		end
	end

	def otherusers
		info = get_userInfo(@@GlobalAuth)
		name = info['fullName']
		@users = User.where.not(name: name)
	end
	def connect(auth)
			client ||= Fitgem::Client.new(
				:consumer_key => '17e009f76e454acda410d3dbeb59d047',
				:consumer_secret => '1db1d74a7ecb4e97aa426fa42126edd1',
				:token => auth.token,
				:secret => auth.secret,
				:user_id => auth.uid,
				:ssl => true
			)
			return client
	end 

private
	def get_activities(auth)
		client = self.connect(auth)
		activities = client.activities_on_date('today')
		return activities
	end
	def get_userInfo(auth)
		client = self.connect(auth)
		userinfo = client.user_info['user']
		return userinfo
	end
end

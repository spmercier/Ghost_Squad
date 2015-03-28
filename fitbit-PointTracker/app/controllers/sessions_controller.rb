class SessionsController < ApplicationController
  def new
  end

  def create
  auth = request.env['omniauth.auth']
  unless @auth = Authorization.find_from_hash(auth)
    # Create a new user or add an auth to existing user, depending on
    # whether there is already a user signed in.
    @auth = Authorization.create_from_hash(auth)
  end
  # Log the authorizing user in.
  self.current_user = @auth.user

	@client ||= Fitgem::Client.new(
		:consumer_key => '17e009f76e454acda410d3dbeb59d047',
		:consumer_secret => '1db1d74a7ecb4e97aa426fa42126edd1',
		:token => @auth.token,
		:secret => @auth.secret,
		:user_id => @auth.uid,
		:ssl => true
	)
  
	render :text => @client.activities_on_date('today') 
end

  def failure
  end
end

class InfoController < ApplicationController
  def index
  	
	get_Fitbit_info = "/public/getFitInfo.rb"
	#@output = `./public/getFitInfo.rb`
	outObject = IO.popen('ruby ./public/getFitInfo.rb')
  	@output = outObject.readlines

  end
end

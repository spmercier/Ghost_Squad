class InfoController < ApplicationController
  def index
  	get_Fitbit_info = "/public/getFitInfo.rb"
	outObject = IO.popen('ruby ./public/getFitInfo.rb > ./public/user.txt')
	
	@points = 0
  	steps = 0
  	caloriesBurned = 0
  	hasHitSummary = 0


  	File.open("public/user.txt", "r").each_line do |line|
	  if line.include? "summary"
	  	hasHitSummary = hasHitSummary + 1
	  end
	  if hasHitSummary == 1
	  	if line.include? "steps"
	  		number = line.scan(/[0-9]+/)
	  		steps = number[0].to_i
	  	elsif line.include? "caloriesBMR"
	  		number = line.scan(/[0-9]+/)
	  		caloriesBurned = number[0].to_i
	  	end #end if
	  end #end if
	end #end loop

	case steps
		when 0..99
		@points = @points + 0
		when 100..199
		  @points = @points + 10
		when 200..599
		  @points = @points + 40
		when 600..1000
		  @points = @points + 100
		else 
		  @points = @points + 500
	end #end steps
	case caloriesBurned
		when 0..499
		@points = @points + 0
		when 500..699
		  @points = @points + 10
		when 700..999
		  @points = @points + 40
		when 1000..2000
		  @points = @points + 100
		else 
		  @points = @points + 500
	end #end caloriesBurned

  end #end index
end #end controller

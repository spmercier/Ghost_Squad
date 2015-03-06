class InfoController < ApplicationController
  def index
  	@steps = 0
  	@hasHitSummary = 0
  	File.open("public/user.txt", "r").each_line do |line|
	  if line.include? "summary"
	  	@hasHitSummary = @hasHitSummary + 1
	  end
	  if @hasHitSummary == 1
	  	if line.include? "steps"
	  		number = line.scan(/[0-9]+/)
	  		@steps = number[0].to_i
	  	end
	  end

	end
  end
end

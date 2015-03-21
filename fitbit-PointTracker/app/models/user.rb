class User < ActiveRecord::Base
	has_many :authorizations

	def self.create_from_hash!(hash)
		create(:name => nil)
	end
end
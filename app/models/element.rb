class Element < ApplicationRecord


	def self.search(search)
		if search
		  self.where(["LOWER('name')  LIKE ?", "LOWER(%#{search}%)"])
		else
		  self.order(created_at: :desc)
		end
	end
end

class Vote < ApplicationRecord

    belongs_to :user
	def self.search(search)
		if search
		  self.where(['question LIKE ?', "%#{search}%"])
		else
		  self.order(created_at: :desc)
		end
	end
end

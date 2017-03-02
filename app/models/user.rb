class User < ApplicationRecord

  has_many :votes
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :authentication_keys => [:login]
  attr_accessor :login

	def self.find_first_by_auth_conditions(warden_conditions)
	  conditions = warden_conditions.dup
	  if login = conditions.delete(:login)
	    where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
	  else
	    if conditions[:username].nil?
	      where(conditions).first
	    else
	      where(username: conditions[:username]).first
	    end
	  end
	end

    validates :username,
	  :presence => true,
	  :uniqueness => {
	    :case_sensitive => false
	}

	validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

	def self.search(search)
		if search
		  self.where(['username LIKE ?', "%#{search}%"])
		else
			[]
		end
	end
end

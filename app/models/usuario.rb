# frozen_string_literal: true

class Usuario < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :trackable, :validatable
	include DeviseTokenAuth::Concerns::User
	
	has_many :jornada_trabalhos
end

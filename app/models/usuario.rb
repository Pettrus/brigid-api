# frozen_string_literal: true

class Usuario < ActiveRecord::Base
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :trackable, :validatable
	include DeviseTokenAuth::Concerns::User
	
	has_many :jornada_trabalhos
	
	validates :nome, :email, presence: true, length: { minimum: 2, maximum: 120 }
	validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
	validates :password, presence: true, length: { minimum: 8, maximum: 200 }, on: :create
	validates :tempo_jornada, presence: true
	
	def self.notificarPonto
		t = Time.now
		hora = t.strftime('%H')
		if hora.to_i == 8
			usuario = Usuario.where.not(endpoint: nil).first

			#Webpush.payload_send(
			#	message: "Não esqueça de bater o ponto",
			#	endpoint: usuario.endpoint,
			#	p256dh: usuario.p256dh,
			#	auth: usuario.auth,
			#	vapid: {
			#		subject: "mailto:pettrus.sherlock@gmail.com",
			#		public_key: ENV['PUBLIC_KEY_NOTIFICATION'],
			#		private_key: ENV['PRIVATE_KEY_NOTIFICATION']
			#	},
			#)
		end
	end
	
	def self.atualizarHorasUsuario(id, horas, jornadaAnterior)
		usuario = Usuario.where(id: id).first
		
		if jornadaAnterior < 0
			extras = usuario.horas_extras - jornadaAnterior
		else
			extras = usuario.horas_extras
		end
		
		usuario.update_attributes(horas_extras: extras + horas)
		
		return extras + horas
	end
end

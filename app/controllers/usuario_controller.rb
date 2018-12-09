class UsuarioController < ApplicationController
	before_action :authenticate_usuario!, only: [:webPush]
	
	def cadastro
		cadastrado = Usuario.where(email: usuario_p[:email]).first
		
		if cadastrado
			render json: true and return
		end
		
		usuario = Usuario.new(usuario_p)
		usuario.uid = usuario.email
		usuario.save()
		
		render json: false
	end
	
	def webPush
		usuario = Usuario.where(id: current_usuario.id).first
		usuario.update_attributes(endpoint: params[:subscription][:endpoint], p256dh: params[:subscription][:keys][:p256dh],
			auth: params[:subscription][:keys][:auth])
		
		render json: true
	end
	
	private
	
	def usuario_p
		params.require(:usuario).permit(:nome, :email, :password, :tempo_jornada)
	end
end
class UsuarioController < ApplicationController
	
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
	
	private
	
	def usuario_p
		params.require(:usuario).permit(:nome, :email, :password, :tempo_jornada)
	end
end
class EventosController < ApplicationController
	before_action :authenticate_usuario!
	
	def index
		eventos = Evento.where(usuario_id: current_usuario.id)
		
		render json: eventos
	end
	
	def create
		id = current_usuario.id
		evento = Evento.new(evento_p.except(:tipo))
		evento.usuario_id = id
		
		if evento.valid?
			ActiveRecord::Base.transaction do
				evento.horas = evento.horas * evento_p[:tipo]
				evento.save()
				
				usuario = Usuario.where(id: id).first
				usuario.update_attributes(horas_extras: usuario.horas_extras + evento.horas)

				render json: evento
			end
		else
            render json: evento.errors.full_messages.to_json, status: :bad_request
        end
	end
	
	private
	
	def evento_p
		params.require(:evento).permit(:nome, :competencia, :horas, :tipo)
	end
end

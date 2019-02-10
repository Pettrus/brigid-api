class JornadaTrabalhoController < ApplicationController
	before_action :authenticate_usuario!
	
	def horasExtras
		horas = Usuario.select(:horas_extras).where(id: current_usuario.id).first
		
		render json: horas
	end
	
	def index
		registros = JornadaTrabalho.where(usuario_id: current_usuario.id).order(:competencia).limit(20)
		
		render json: registros
	end
	
	def create
		jornada = JornadaTrabalho.where(usuario_id: current_usuario.id, competencia: Date.today, fim: nil).first
		
		ActiveRecord::Base.transaction do
			if jornada.nil?
				novaJornada = JornadaTrabalho.salvar(current_usuario.id)

				render json: {
					jornada: novaJornada
				}
			else
				horas = JornadaTrabalho.atualizar(jornada, current_usuario, (jornada.inicio.saturday? || jornada.inicio.sunday?))

				render json: {
					jornada: jornada,
					horas: horas
				}
			end
		end
	end
	
	private
	
	def jornada_p
		params.require(:jornada).permit(:id, :inicio, :fim, :competencia)
	end
end

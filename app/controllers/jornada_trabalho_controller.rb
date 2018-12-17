class JornadaTrabalhoController < ApplicationController
	before_action :authenticate_usuario!
	
	def horasExtras
		horas = Usuario.select(:horas_extras).where(id: current_usuario.id).first
		
		render json: horas
	end
	
	def listarHistorico
		registros = JornadaTrabalho.where(usuario_id: current_usuario.id).last(20)
		
		render json: registros
	end
	
	def registrarPonto
		jornada = JornadaTrabalho.where(usuario_id: current_usuario.id, competencia: Date.today, fim: nil).first
		
		ActiveRecord::Base.transaction do
			if jornada.nil?
				novaJornada = JornadaTrabalho.salvar(current_usuario.id)

				render json: {
					jornada: novaJornada
				}
			else
				horas = JornadaTrabalho.atualizar(jornada, current_usuario)

				render json: {
					jornada: jornada,
					horas: horas
				}
			end
		end
	end
	
	def sincronizarOffline
		ActiveRecord::Base.transaction do
			if jornada_p[:id].nil?
				jornada = JornadaTrabalho.new(jornada_p)
				JornadaTrabalho.salvarOffline(jornada, current_usuario)
			else
				JornadaTrabalho.atualizarOffline(jornada_p, current_usuario)
			end
		
			render json: true
		end
	end
	
	private
	
	def jornada_p
		params.require(:jornada).permit(:id, :inicio, :fim, :competencia)
	end
end

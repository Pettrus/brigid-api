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
		jornada = JornadaTrabalho.where(usuario_id: current_usuario.id, competencia: Date.today).first
		
		ActiveRecord::Base.transaction do
			if jornada.nil? || !jornada.fim.nil?
				novaJornada = JornadaTrabalho.new
				novaJornada.competencia = Date.today
				novaJornada.inicio = Time.now
				novaJornada.usuario_id = current_usuario.id
				novaJornada.save()

				render json: novaJornada
			else
				horas = ((Time.now - jornada.inicio) / 1.hours) - current_usuario.tempo_jornada
				jornada.update_attributes(fim: Time.now, horas: horas)

				usuario = Usuario.where(id: current_usuario.id).first
				usuario.update_attributes(horas_extras: usuario.horas_extras + horas)

				render json: jornada
			end
		end
	end
	
	def sincronizarOffline
		ActiveRecord::Base.transaction do
			if jornada_p[:id].nil?
				jornada = JornadaTrabalho.new(jornada_p)
				jornada.usuario_id = current_usuario.id
				jornada.save()
			else
				jornada = JornadaTrabalho.where(id: jornada_p[:id], usuario_id: current_usuario.id).first
				horas = ((Time.parse(jornada_p[:fim]) - jornada.inicio) / 1.hours) - current_usuario.tempo_jornada

				jornada.update_attributes(fim: Time.now, horas: horas)

				usuario = Usuario.where(id: current_usuario.id).first
				usuario.update_attributes(horas_extras: usuario.horas_extras + horas)
			end
		
			render json: true
		end
	end
	
	private
	
	def jornada_p
		params.require(:jornada).permit(:id, :inicio, :fim, :competencia)
	end
end

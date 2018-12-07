class JornadaTrabalho < ApplicationRecord
	belongs_to :usuario
	
	def self.salvar(usuario)
		novaJornada = JornadaTrabalho.new
		novaJornada.competencia = Date.today
		novaJornada.inicio = Time.now
		novaJornada.usuario_id = usuario
		novaJornada.save()
		
		return novaJornada
	end
	
	def self.atualizar(jornada, usuario)
		tempJornada = usuario.tempo_jornada
		total = JornadaTrabalho.select(:horas).where(usuario_id: usuario.id, competencia: Date.today)
			.where.not(horas: nil).order("inicio DESC").first
		
		if !total.nil?
			if total.horas < 0
				tempJornada = total.horas * -1
			else
				tempJornada = 0
			end
		end
		
		horas = ((Time.now - jornada.inicio) / 1.hours) - tempJornada
		jornada.update_attributes(fim: Time.now, horas: horas)

		usuario = Usuario.where(id: usuario.id).first
		usuario.update_attributes(horas_extras: usuario.horas_extras + horas)
	end
end

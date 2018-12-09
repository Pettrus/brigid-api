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
		tempJornada = tempoJornadaDia(Date.today, usuario)
		
		horas = ((Time.now - jornada.inicio) / 1.hours) - tempJornada
		jornada.update_attributes(fim: Time.now, horas: horas)
		atualizarHorasUsuario(usuario.id, horas)
	end
	
	def self.salvarOffline(jornada, usuario)
		tempJornada = tempoJornadaDia(jornada.competencia, usuario)
		
		if !jornada.fim.nil?
			jornada.horas = ((jornada.fim - jornada.inicio) / 1.hours) - tempJornada
			atualizarHorasUsuario(usuario.id, jornada.horas)
		end
		
		jornada.usuario_id = usuario.id
		jornada.save()
	end
	
	def self.atualizarOffline(jornada, usuario)
		tempJornada = tempoJornadaDia(jornada[:competencia], usuario)
		
		jornadaTrab = JornadaTrabalho.where(usuario_id: usuario.id, competencia: jornada[:competencia], fim: nil).first
		horas = ((Time.parse(jornada[:fim]) - jornadaTrab.inicio) / 1.hours) - tempJornada
		
		jornadaTrab.update_attributes(fim: jornada[:fim], horas: horas)
		atualizarHorasUsuario(usuario.id, horas)
	end
		
	private
		
	def self.tempoJornadaDia(competencia, usuario)
		tempJornada = usuario.tempo_jornada
		total = JornadaTrabalho.where(usuario_id: usuario.id, competencia: competencia)
			.where.not(horas: nil).order("inicio DESC").first
		
		if !total.nil?
			if total.horas < 0
				tempJornada = total.horas * -1
			else
				tempJornada = 0
			end
		end
		
		return tempJornada
	end
	
	def self.atualizarHorasUsuario(id, horas)
		usuario = Usuario.where(id: id).first
		usuario.update_attributes(horas_extras: usuario.horas_extras + horas)
	end
end

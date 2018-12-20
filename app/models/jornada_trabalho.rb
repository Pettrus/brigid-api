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
		jornadaAnterior = tempoJornadaDia(Date.today, usuario)
		
		if !jornadaAnterior.nil? && jornadaAnterior >= 0
			horas = ((Time.now - jornada.inicio) / 1.hours)
		else
			diferenca = (jornadaAnterior.nil? ? 0 : usuario.tempo_jornada - (jornadaAnterior * -1))
			
			horas = ((Time.now - jornada.inicio) / 1.hours) - usuario.tempo_jornada + diferenca
		end
		
		jornada.update_attributes(fim: Time.now, horas: horas)
		return Usuario.atualizarHorasUsuario(usuario.id, horas, (jornadaAnterior.nil? ? 0 : jornadaAnterior))
	end
	
	private
		
	def self.tempoJornadaDia(competencia, usuario)
		total = JornadaTrabalho.where(usuario_id: usuario.id, competencia: competencia)
			.where.not(horas: nil).order("inicio DESC").first
		
		if !total.nil?
			return total.horas
		end
		
		return nil
	end
end

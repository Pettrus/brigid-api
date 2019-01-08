require 'rails_helper'

RSpec.describe JornadaTrabalho, type: :model do
	describe 'teste de escopo' do
		before(:each) do
			@usuario = Usuario.new(nome: 'Teste', email: 'teste@teste.com.br', uid: 'teste@teste.com.br', password: 'test12345', horas_extras: 0)
			@usuario.save
			
			@jornadaT = JornadaTrabalho.new(competencia: Date.today, inicio: Time.now, usuario_id: @usuario.id)
			@jornadaT.save
			
			@jornadaFinalSemana = JornadaTrabalho.new(competencia: Date.today, inicio: Time.now - 3.hours, usuario_id: @usuario.id)
			@jornadaFinalSemana.save
			
			JornadaTrabalho.new(competencia: '2018-01-01', inicio: '2018-01-01 08:00', fim: '2018-01-01 17:00', horas: 8, usuario_id: @usuario.id).save
		end
		
		it 'salvar jornada' do
			jornada = JornadaTrabalho.salvar(@usuario)
			
			expect(jornada).to be_a JornadaTrabalho
		end
		
		it 'atualizar horas' do
			horas = JornadaTrabalho.atualizar(@jornadaT, @usuario, false)
			expect(horas.round(2)).to eq(-8)
		end
		
		it 'atualizar horas final de semana' do
			horas = JornadaTrabalho.atualizar(@jornadaFinalSemana, @usuario, true)
			expect(horas.round(2)).to eq(3)
		end
		
		it 'trazer tempo jornada trabalho COM horas extras' do
			horas = JornadaTrabalho.tempoJornadaDia('2018-01-01', @usuario)
			expect(horas).to eq(8)
		end
		
		it 'trazer tempo jornada trabalho SEM horas extras' do
			horas = JornadaTrabalho.tempoJornadaDia(Date.today, @usuario)
			expect(horas).to be_nil
		end
	end
end
require 'rails_helper'

RSpec.describe Usuario, type: :model do
	describe 'testes de validação' do
		it 'garantir nome é obrigatorio' do
			usuario = Usuario.new(email: 'teste@teste.com.br', password: 'test12345').save
			expect(usuario).to eq(false)
		end
		
		it 'garantir email é obrigatorio' do
			usuario = Usuario.new(nome: 'Teste', password: 'test12345').save
			expect(usuario).to eq(false)
		end
		
		it 'deveria salvar' do
			usuario = Usuario.new(nome: 'Teste', email: 'teste@teste.com.br', uid: 'teste@teste.com.br', password: 'test12345').save
			expect(usuario).to eq(true)
		end
	end
	
	describe 'testes de escopo' do
		before(:each) do
			@usuario = Usuario.new(nome: 'Teste', email: 'teste@teste.com.br', uid: 'teste@teste.com.br', password: 'test12345', horas_extras: 0)
			@usuario.save
			@usuario2 = Usuario.new(nome: 'Teste', email: 'teste2@teste.com.br', uid: 'teste2@teste.com.br', password: 'test12345', horas_extras: -7)
			@usuario2.save
		end
		
		it 'atualizar horas extras ja terminado jornada' do
			horas = Usuario.atualizarHorasUsuario(@usuario.id, 3, 0)
			expect(horas).to eq(3)
		end
		
		it 'atualizar horas extras ainda nao terminado jornada' do
			horas = Usuario.atualizarHorasUsuario(@usuario2.id, 2, -7)
			expect(horas).to eq(2)
		end
	end
end

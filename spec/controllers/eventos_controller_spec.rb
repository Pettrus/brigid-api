require 'rails_helper'

RSpec.describe EventosController, type: :controller do
	include Devise::Test::ControllerHelpers
	
	before(:each) do
		@usuario = Usuario.new(nome: 'Teste', email: 'teste@teste.com.br', uid: 'teste@teste.com.br', password: 'test12345', horas_extras: 0)
		@usuario.save
		
		request.headers.merge! @usuario.create_new_auth_token()
	end
	
	describe 'teste de rotas' do
		it 'GET #index' do
			get :index
			expect(response).to be_success
		end
		
		it 'POST #create' do
			post :create, params: {evento: {nome: 'Teste', competencia: Date.today, horas: 2, tipo: 1}}
			expect(response).to be_success
		end
	end
end
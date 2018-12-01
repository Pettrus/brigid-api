Rails.application.routes.draw do
 	mount_devise_token_auth_for 'Usuario', at: 'auth'
	
	scope '/jornada-trabalho' do
		get 'horas-extras' => 'jornada_trabalho#horasExtras'
		get 'historico' => 'jornada_trabalho#listarHistorico'
		
		post 'registrar-ponto' => 'jornada_trabalho#registrarPonto'
	end
end
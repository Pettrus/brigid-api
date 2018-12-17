Rails.application.routes.draw do
 	mount_devise_token_auth_for 'Usuario', at: 'auth'
	
	scope '/usuario' do
		post 'cadastro' => 'usuario#cadastro'
		post 'webpush' => 'usuario#webPush'
	end
	
	scope '/jornada-trabalho' do
		get 'horas-extras' => 'jornada_trabalho#horasExtras'
		get 'historico' => 'jornada_trabalho#listarHistorico'
		
		post 'registrar-ponto' => 'jornada_trabalho#registrarPonto'
		post 'sincronizar' => 'jornada_trabalho#sincronizarOffline'
	end
	
	resources :eventos
end
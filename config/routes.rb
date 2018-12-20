Rails.application.routes.draw do
 	mount_devise_token_auth_for 'Usuario', at: 'auth'
	
	scope '/usuario' do
		post 'cadastro' => 'usuario#cadastro'
		post 'webpush' => 'usuario#webPush'
	end
	
	scope '/jornada-trabalho' do
		get 'horas-extras' => 'jornada_trabalho#horasExtras'
	end
	
	resources :jornada_trabalho, path: "jornada-trabalho"
	resources :eventos
end
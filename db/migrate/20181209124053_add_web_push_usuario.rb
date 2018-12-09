class AddWebPushUsuario < ActiveRecord::Migration[5.0]
	def up
		add_column :usuarios, :endpoint, :string, null: true
		add_column :usuarios, :p256dh, :string, null: true
		add_column :usuarios, :auth, :string, null: true
	end
end
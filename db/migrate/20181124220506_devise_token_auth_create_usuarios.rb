class DeviseTokenAuthCreateUsuarios < ActiveRecord::Migration[5.0]
  def up
    
    create_table :usuarios, id: :uuid do |t|
      ## Required
      t.string :provider, :null => false, :default => "email"
      t.string :uid, :null => false, :default => ""

      ## Database authenticatable
      t.string :encrypted_password, :null => false, :default => ""

      ## Trackable
      t.integer  :sign_in_count, :default => 0, :null => false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## User Info
      t.string :nome, limit: 120, null: false
      t.string :email, limit: 120, null: false
	  t.string :avatar, null: true
		
	  t.float :tempo_jornada, null: false, default: 8
	  t.float :horas_extras, null: false, default: 0

      ## Tokens
      t.json :tokens

      t.timestamps
    end

    add_index :usuarios, :email,                unique: true
    add_index :usuarios, [:uid, :provider],     unique: true
    # add_index :usuarios, :unlock_token,       unique: true
  end
	
  def down
	  drop_table :usuarios
  end
end

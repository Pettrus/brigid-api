class CreateEventos < ActiveRecord::Migration[5.0]
	def up
		create_table :eventos do |t|
			t.string :nome, limit: 70, null: false
			t.float :horas, null: false
			t.date :competencia, null: false
			
			t.references :usuario, type: :uuid, foreign_key: true, null: false
			
			t.timestamps
		end
	end
	
	def down
		drop_table :eventos
	end
end
class CreateJornadaTrabalhos < ActiveRecord::Migration[5.0]
	def up
		create_table :jornada_trabalhos, id: :uuid do |t|
			t.date :competencia, null: false
			t.datetime :inicio, null: false
			t.datetime :fim, null: true
			
			t.float :horas, null: true
			
			t.references :usuario, type: :uuid, foreign_key: true, null: false
			t.timestamps
		end
	end
	
	def down
		drop_table :jornada_trabalhos
	end
end
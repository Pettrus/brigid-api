class Evento < ApplicationRecord
	belongs_to :usuario
	
	strip_attributes
	
	validates :nome, presence: true, length: { minimum: 2, maximum: 70 }
	validates_date :competencia, on_or_before: lambda { Date.current }
	validates_numericality_of :horas
end
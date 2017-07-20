class Landmark <ActiveRecord::Base
	belongs_to :figure
	has_many :titles, through: :figures


	def self.from_params(landmark, figure)
		if landmark[:name] != ""
			Landmark.create(name: landmark[:name], year_completed: landmark[:year_completed], figure_id: figure.id)
		end
	end

end

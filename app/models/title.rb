class Title < ActiveRecord::Base
	has_many :figure_titles
	has_many :figures, through: :figure_titles

	def self.from_params(name, figure)
		if name != ""
			title = Title.create(name: name)
			FigureTitle.create(figure_id: figure.id, title_id: title.id)
		end
	end
end
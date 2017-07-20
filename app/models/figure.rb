class Figure < ActiveRecord::Base
	has_many :figure_titles
	has_many :titles, through: :figure_titles
	has_many :landmarks

	def set_landmarks(landmarks)
		if landmarks != nil
			landmarks.each do |landmark_id|
				landmark = Landmark.all.find(landmark_id)
				landmark.figure_id = self.id
				landmark.save
			end
		end
	end

	def set_titles(titles)
		if titles != nil
			titles.each do |title_id|
				FigureTitle.create(figure_id: self.id, title_id: title_id)
			end
		end
	end

	def purge_titles(titles)
		if titles.nil?
				self.figure_titles.delete_all
		else
			self.figure_titles.each do |figure_title|
				if !titles.include?(figure_title.id)
					figure_title.destroy
				end
			end
		end
	end

	def purge_landmarks(landmarks)
		if landmarks.nil?
			self.landmarks.each do |landmark|
				landmark.figure_id = nil
				landmark.save
			end
		else
			Landmark.where("figure_id = #{self.id}").each do |landmark|
				if !landmarks.include?(landmark.id)
					landmark.figure_id = nil
					landmark.save
				end
			end
		end
	end
end
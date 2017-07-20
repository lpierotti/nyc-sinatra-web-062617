class LandmarksController < ApplicationController

	get '/landmarks' do 
		@landmarks = Landmark.all
		erb :"/landmarks/index"
	end

	get '/landmarks/new' do 
		@figures = Figure.all
		erb :"/landmarks/new"
	end

	post '/landmarks' do 
		landmark = Landmark.create(params[:landmark])
		redirect "/landmarks/#{landmark.id}"
	end

	get '/landmarks/:id' do
		@landmark = Landmark.all.find(params[:id])
		erb :"/landmarks/show"

	end

	get '/landmarks/:id/edit' do 
		@landmark = Landmark.all.find(params[:id])
		@figures = Figure.all
		erb :"/landmarks/edit"
	end

	post '/landmarks/:id/edit' do
		landmark = Landmark.all.find(params[:id])
		params[:landmark].each do |key, value|
			landmark.send("#{key}=", value)
		end
		landmark.save
		redirect "/landmarks/#{params[:id]}"
	end

end

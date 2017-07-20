class FiguresController < ApplicationController

	get '/figures' do 
		@figures = Figure.all
		erb :"/figures/index"
	end

	get '/figures/new' do 
		@titles = Title.all
		@landmarks = Landmark.all
		erb :"/figures/new"
	end

	post '/figures' do 
		
		figure = Figure.create(params[:figure])
		figure.set_titles(params[:figure][:title_ids])
		figure.set_landmarks(params[:figure][:landmark_ids])
		
		Landmark.from_params(params[:landmark], figure)
		Title.from_params(params[:title][:name], figure)
		
		redirect "/figures"
	end

	get '/figures/:id' do 
		@figure = Figure.all.find(params[:id])
		erb :"figures/show"
	end

	get '/figures/:id/edit' do 
		@figure = Figure.all.find(params[:id])
		@titles = Title.all
		@landmarks = Landmark.all

		erb :"/figures/edit"
	end



	post '/figures/:id/edit' do 
		figure = Figure.all.find(params[:id])
		figure.name = params[:figure][:name]
		
		figure.purge_titles(params[:figure][:title_ids])
		figure.set_titles(params[:figure][:title_ids])
		figure.purge_landmarks(params[:figure][:landmark_ids])
		figure.set_landmarks(params[:figure][:landmark_ids])

		Landmark.from_params(params[:landmark], figure)
		Title.from_params(params[:title][:name], figure)

		figure.save
		redirect "/figures/#{params[:id]}"
	end
end
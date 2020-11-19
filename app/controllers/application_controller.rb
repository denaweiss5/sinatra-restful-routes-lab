require './config/environment'

class ApplicationController < Sinatra::Base
  set :views, Proc.new { File.join(root, "../views/") }

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  #index
  get '/recipes' do
    @recipes = Recipe.all 
    erb :index
  end

  #new
  get '/recipes/new' do
    erb :new
  end

  #create
  post '/recipes' do
    @recipe = Recipe.create(params)
    @recipe.save

    redirect to '/recipes/#{@recipe.id}'
  end

  #show
  get '/recipes/:id' do 
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  #edit
  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  #update
  patch '/recipes/:id' do 
    @recipe = Recipe.find(params[:id])
    @recipe.name = params[:name]
    @recipe.ingredients = params[:ingredients]
    @recipe.cook_time = params[:cook_time]
    @recipe.save

    redirect to '/recipes/#{@recipe.id}'
  end

  #delete
  delete '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    @recipe.delete

    redirect to "/recipes"
  end



end

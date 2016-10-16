class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do
    @recipes = Recipe.all
    erb :index
  end

  post '/recipes' do
    new_recipe = Recipe.create(
      name: params[:name],
      ingredients: params[:ingredients],
      cook_time: params[:cook_time]
      )
    redirect to "/recipes/#{new_recipe.id}"
  end

  get '/recipes/new' do
    erb :new
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do
    Recipe.update(
      params[:id],
      name: params[:name],
      ingredients: params[:ingredients],
      cook_time: params[:cook_time]
      )

    redirect to "/recipes/#{params[:id]}"
  end

  delete '/recipes/:id/delete' do
    Recipe.destroy(params[:id])

    redirect to "/recipes"
  end
end
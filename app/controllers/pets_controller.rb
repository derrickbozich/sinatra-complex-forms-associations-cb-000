class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do

    @pet = Pet.create(name: params[:pet][:name])

    if !params[:pet][:owner][:name].empty?
      @pet.owner = Owner.create(name: params[:pet][:owner][:name])
    else
      @pet.owner_id = params[:pet][:owner_id][0].to_i
      @pet.owner = Owner.find_by_id(@pet.owner_id)
    end

    @pet.save
    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  post '/pets/:id' do
    @pet = Pet.find_by_id(params[:id])
    @pet.name = params[:pet][:name]
    if params[:owner].empty?
      @pet.owner = Owner.find_by_id(params[:owner][:name])
    else
      
    end
    
    binding.pry

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id/edit' do

    @pet = Pet.find_by_id(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end




end

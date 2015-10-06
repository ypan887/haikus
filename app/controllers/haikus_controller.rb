class HaikusController < ApplicationController

  def index
    haikus = Haiku.all
    render json: haikus
  end

  def show
    haiku = Haiku.find(params[:id])
    render json: haiku
  end

  def create
    haiku = Haiku.new(haiku_params)
    if haiku.save
      render json: haiku
      head 201
    else
      render json: {errors: haiku.errors}
    end
  end

  def update
    haiku = Haiku.find(params[:id])
    if haiku.update_attributes(haiku_params)
      render json: haiku
    else
      render json: {errors: haiku.errors}
      head 400
    end
  end

  def destroy
    haiku = Haiku.find(params[:id])
    haiku.destroy
    head 204
  end

  private

  def haiku_params
    params.permit()
  end

end

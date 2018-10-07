class PlacesController < ApplicationController
  def index
  end

  def show
    places = Rails.cache.read(session[:search_city])
    @place = places.select { |place| place.id == params[:id] }.first
  end

  def search
    session[:search_city] = params[:city]
    @places = BeermappingApi.places_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end
end

class MovieGenresController < ApplicationController
  def index
    @genres = MovieGenre.all
  end
end

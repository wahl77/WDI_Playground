require "sinatra"
require "sinatra/reloader"

require "image_suckr"
require "stock_quote"
require "movies"

get "/" do
	erb :index
end
get "/Movies/*" do
	if params[:film_name] != nil
	 	@my_movie = Movies.find_by_title(params[:film_name]) 
		@director = @my_movie.director
		@rating = @my_movie.rating
		@title = @my_movie.title
		@rating = get_rating(@my_movie)
	end
	erb :movies
end
get "/Stocks/*" do
	erb :stocks
end
get "/Images/*" do
	erb :images
end

def get_rating(movie)
	initial = /imdbRating\"=>\"[0-9]\.[0-9]\"/.match(movie.inspect)[0]
	regex = /[0-9]\.[0-9]/.match(initial)
	return regex
end


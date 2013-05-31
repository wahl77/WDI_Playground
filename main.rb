require "sinatra"
require "sinatra/reloader"

require "image_suckr"
require "stock_quote"
require "movies"

get "/" do
	erb :index
end
get "/Movies/*" do
	@found = 0
	if params[:film_name] != nil
	 	@my_movie = Movies.find_by_title(params[:film_name]) 
		puts "HEY"
		puts @my_movie.director 
		if @my_movie.director != nil 
			suckr = ImageSuckr::GoogleSuckr.new   
			@found = 1
			@director = @my_movie.director
			@title = @my_movie.title
			@rating = get_rating(@my_movie)
			@url = suckr.get_image_url({"q" => "#{@title} #{@year}"})
		else
			@found = 0
		end
	end
	erb :movies
end
get "/Stocks/*" do
	if params[:stock] != nil
		@found = 1
		begin
		 @stock = StockQuote::Stock.quote(params[:stock])
		 @last = @stock.last
		 @company = @stock.company
		rescue 
			@found = 0
		end
	end
	erb :stocks end
get "/Images/*" do
	erb :images
end

def get_rating(movie)
	initial = /imdbRating\"=>\"[0-9]\.[0-9]\"/.match(movie.inspect)[0]
	regex = /[0-9]\.[0-9]/.match(initial)
	return regex
end


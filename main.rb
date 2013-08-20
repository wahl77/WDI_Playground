require "sinatra"
require "sinatra/reloader"

require "image_suckr"
require "stock_quote"
require "movies"

get "/" do
	@page = "Home"
	erb :index
end

post "/Movies/*" do
	@page="Movies"
	@found = 0
	if params[:film_name] != nil && params[:film_name].to_s.length > 0 
	 	@my_movie = Movies.find_by_title(params[:film_name]) 
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

post "/Stocks/*" do
	@page = "Stocks"
	if params[:stock] != nil && params[:stock].to_s.length > 0
		@found = 1
		begin
		 @stock = StockQuote::Stock.quote(params[:stock])
		 @last = @stock.last
		 @company = @stock.company
		 @market_cap = @stock.market_cap
		 @url = "https://www.google.com" + @stock.chart_url
		rescue 
			@found = 0
		end
	end
	erb :stocks 
end

post "/Images/random_image" do
	@page = "Image"
	words = ["hello", "franky", "car", "play", "ok", "dude", "max", "me", "patsy" ]
	params[:image] = ""
	random_number = rand(1000) % words.length
	variable = words[random_number]
	suckr = ImageSuckr::GoogleSuckr.new   
	@url = suckr.get_image_url({"q" => "#{variable}"})
  erb :images
end

post "/Images/*" do
	@page = "Images"
	if params[:image] != nil && params[:image].to_s.length > 0
		suckr = ImageSuckr::GoogleSuckr.new   
		variable = params[:image]
		@url = suckr.get_image_url({"q" => "#{variable}"})
	end
	erb :images
end














get "/Movies/*" do
	@page="Movies"
	@found = 0
	if params[:film_name] != nil && params[:film_name].to_s.length > 0 
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
	@page = "Stocks"
	if params[:stock] != nil && params[:stock].to_s.length > 0
		@found = 1
		begin
		 @stock = StockQuote::Stock.quote(params[:stock])
		 @last = @stock.last
		 @company = @stock.company
		 @market_cap = @stock.market_cap
		 @url = "https://www.google.com" + @stock.chart_url
		rescue 
			@found = 0
		end
	end
	erb :stocks 
end

get "/Images/random_image" do
	@page = "Images"
	words = ["hello", "franky", "car", "play", "ok", "dude", "max", "me" ]
	params[:image] = ""
	random_number = rand(1000) % words.length
	variable = words[random_number]
	suckr = ImageSuckr::GoogleSuckr.new   
	@url = suckr.get_image_url({"q" => "#{variable}"})
  erb :images
end

get "/Images/*" do
	@page = "Images"
	if params[:image] != nil && params[:image].to_s.length > 0
		suckr = ImageSuckr::GoogleSuckr.new   
		variable = params[:image]
		@url = suckr.get_image_url({"q" => "#{variable}"})
	end
	erb :images
end
 







def get_rating(movie)
	initial = /imdbRating\"=>\"[0-9]\.[0-9]\"/.match(movie.inspect)[0]
	regex = /[0-9]\.[0-9]/.match(initial)
	return regex
end

























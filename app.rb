require "sinatra"
require "sinatra/reloader"
require "http"
require "json"

get("/") do
  exchange_rate_key = ENV["EXCHANGE_RATE_API"]
  
  api_url = "https://api.exchangerate.host/list?access_key=#{exchange_rate_key}"
  
  #place a GET request to the URL
  raw_data = HTTP.get(api_url)

  #convert raw requests to a string
  raw_data_string = raw_data.to_s

  #parse JSON response
  parsed_data = JSON.parse(raw_data) 
  
  #get the symbols from JSON
  @currencies = parsed_data.fetch("currencies")

  #get symbols
  @symbols = @currencies.keys

  #render a view template where I show the symbols
  
  erb(:home)

  
end

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
  @from_currency = @currencies.keys

  erb(:home)
  
end

get("/:from_currency") do
  exchange_rate_key = ENV["EXCHANGE_RATE_API"]
  api_url = "https://api.exchangerate.host/list?access_key=#{exchange_rate_key}"  
  @original_currency = params.fetch("from_currency")

  #place a GET request to the URL
  raw_data = HTTP.get(api_url)

  #convert raw requests to a string
  raw_data_string = raw_data.to_s

  #parse JSON response
  parsed_data = JSON.parse(raw_data) 
  
  #get the symbols from JSON
  @currencies = parsed_data.fetch("currencies")

  #get symbols
  @to_currencies = @currencies.keys

  erb(:from_currency)
end


get("/:from_currency/:to_currency") do
  @original_currency = params.fetch("from_currency")
  @destination_currency = params.fetch("to_currency")
  exchange_rate_key = ENV["EXCHANGE_RATE_API"]
  api_url = "https://api.exchangerate.host/convert?access_key=#{exchange_rate_key}&from=#{@original_currency}&to=#{@destination_currency}&amount=1"

  #get raw data
  raw_data = HTTP.get(api_url).to_s
  #get parsed data
  parsed_data = JSON.parse(raw_data)

  #get results
  @conversion = parsed_data.fetch("result").to_s

  erb(:conversion)
end

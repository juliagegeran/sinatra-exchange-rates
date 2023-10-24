require "sinatra"
require "sinatra/reloader"

get("/") do
  api_url = "https://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_KEY"]}"
  
  erb(:home)
end

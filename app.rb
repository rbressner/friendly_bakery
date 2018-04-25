require 'sinatra'


get "/" do
erb :index
end

get "/muffins" do
  erb :muffins
end

get "/cookies" do
  erb :cookies
end

get "/cake" do
  erb :cake
end

get "/contact" do
  erb :contact
end

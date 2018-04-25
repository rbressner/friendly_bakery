require 'sinatra'
require 'sendgrid-ruby'
include SendGrid

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

post "/response" do

  from = Email.new(email: 'rachel.bressner@gmail.com')
  to = Email.new(email: params[:email])
  subject = 'hi ' + params[:name]
  content = Content.new(type: 'text/plain', value: 'hi there')
  mail = Mail.new(from, subject, to, content)

  sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
  response = sg.client.mail._('send').post(request_body: mail.to_json)
  puts response.status_code
  puts response.body
  puts response.headers

  erb :response
end

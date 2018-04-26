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
  content = Content.new(type: 'text/html', value:
    "<html><body style='background-color: #e6ffe6; text-align: center;'>
    <img src='https://image.ibb.co/nmKhgx/logo.png' alt='logo' border='0' style='display: block; margin-right: auto; margin-left: auto; top: 0; width: 25%;'>
    <h1>Thanks for your interest in our baked goods!</h1><br>
    <img src='https://preview.ibb.co/nOvD4H/catalogue.jpg' alt='catalogue' border='0' style='  display: block; margin-left: auto; margin-right: auto;'>
    <br><h2>With love, <br> Your friends at Mary Jane's</h2>
    </body></html>")
  mail = Mail.new(from, subject, to, content)

  sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
  response = sg.client.mail._('send').post(request_body: mail.to_json)
  puts response.status_code
  puts response.body
  puts response.headers

  erb :response
end

require 'net/https'
require 'uri'
require 'json'
require 'faraday'
require 'faraday_middleware'

#リクルートAPI
URL_Recruit = 'https://api.a3rt.recruit-tech.co.jp/talk/v1/smalltalk'
KEY_Recruit = 'mkxumAgVxDuMXYF6EyHPKyPUrLGD2Cun'

message = ARGV[0]

conn = Faraday::Connection.new(:url => URL_Recruit ) do |builder|
    builder.use Faraday::Request::UrlEncoded
    builder.use Faraday::Response::Logger
    builder.use Faraday::Adapter::NetHttp
end

params = {apikey: KEY_Recruit, query: message}

response = conn.post URL_Recruit, params
json = JSON.parse(response.body)
text = json["results"][0]["reply"]
puts text

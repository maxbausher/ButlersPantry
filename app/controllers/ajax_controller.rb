class AjaxController < ApplicationController

  def jquery
  end

  def etsy
    headers['Access-Control-Allow-Origin'] = '*'
    limit = params[:limit] || 10
    url =
    "https://api.etsy.com/v2/listings/active?api_key=tnv0l61ii0gitu3moz3ba41m&includes=MainImage&limit=#{ limit }&keyword=#{ params[:keyword] }"
    response = HTTParty.get url, format: :json

    render json: response.parsed_response
  end

  def eventful
    headers['Access-Control-Allow-Origin'] = '*'
    url = "http://api.eventful.com/json/events/search?app_key=gwV3mHmgzBjg8sDK&category=#{ params[:category] }&l=#{ params[:location] }"
    # if param....
    #   url += "...."
    # end
    response = HTTParty.get url, format: :json

    render json: response.parsed_response
  end

  def amazon
    headers['Access-Control-Allow-Origin'] = '*'
    #
    # require 'openssl'
    # require 'Base64'
    # require 'cgi'
    # require 'pry'
    # require 'httparty'


    category = "All"
    timestamp = Time.now.iso8601

    querystring = "AWSAccessKeyId=AKIAIS25MPWFOL33XNFA&AssociateTag=butlerspantry-20&Keywords=#{ params[:keyword] }&Operation=ItemSearch&ResponseGroup=Images%2CItemAttributes&SearchIndex=#{ params[:category] }&Service=AWSECommerceService&Timestamp=#{ CGI.escape(timestamp) }&Version=2013-08-01"

    key = "KHDI1WsLS8KGS1doUZrfWajgACGxhO99jNaxTBui"

    data = "GET
webservices.amazon.com
/onca/xml
#{ querystring }"

    puts "signature data to encode:", data

    signature = Base64.encode64(OpenSSL::HMAC.digest(OpenSSL::Digest.new('sha256'), key, data)).strip()
    signature = CGI.escape( signature )

    puts "--------------------"
    puts "encoded signature: ", signature
    puts "--------------------"

    res = HTTParty.get("http://webservices.amazon.com/onca/xml?#{ querystring }&Signature=#{ signature }")

    puts res

    render json: res.parsed_response

  end
end

# const ETSY_API_KEY = "tnv0l61ii0gitu3moz3ba41m";
# const ETSY_ROOT_URL = `https://api.etsy.com/v2/listings/active.js?api_key=${ETSY_API_KEY}`;
#
# export const FETCH_ETSY = "FETCH_ETSY";
#
# export function fetchProducts(keyword) {
#   const url = `${ETSY_ROOT_URL}&keyword=${keyword}`;

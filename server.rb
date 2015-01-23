require 'sinatra'
require 'rack-flash'
require_relative 'lib/scrabbler'

class ScrabblerApp < Sinatra::Application

  # use Rack::Flash
  include Rack::Utils
  alias_method :h, :escape_html

  get '/' do
    erb :index
  end

  post '/' do
    p params
    scrabbler = Scrabbler.new
    @result = scrabbler.scrabblefy!(params[:letters], params[:number].to_i)
    p @result
    erb :index
  end

end
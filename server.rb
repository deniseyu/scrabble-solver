require 'sinatra'
require 'rack-flash'
require_relative 'lib/scrabbler'

class ScrabblerApp < Sinatra::Application

  # use Rack::Flash
  include Rack::Utils
  alias_method :h, :escape_html

  SCRABBLER = Scrabbler.new
  get '/' do
    @values = SCRABBLER.values
    erb :index
  end

  post '/' do
    @values = SCRABBLER.values
    @result = SCRABBLER.scrabblefy!(params[:letters], params[:number].to_i)
    erb :index
  end

  get '/about' do
    erb :about
  end


end
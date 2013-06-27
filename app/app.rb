# encoding utf-8

require 'sinatra/base'
require 'sinatra/flash'
require 'sass'
require 'haml'

class App < Sinatra::Base
  set :root, settings.root + "/.."

  # Load config.yml into settings.config variable
  set :config, YAML.load_file("#{settings.root}/config/config.yml")[settings.environment.to_s]

  set :environment, ENV["RACK_ENV"] || "development"
  set :public_folder, "app/public"
  set :views, "app/views"
  set :haml, { :format => :html5 }

  # Load library files
  Dir[settings.root + '/lib/*.rb'].each {|file| require file }

  ######################################################################
  # Configurations for different environments
  ######################################################################

  configure :staging do
    enable :logging
  end

  configure :development do
    enable :logging
  end

  ######################################################################

  helpers do
    include Rack::Utils
    alias_method :h, :escape_html

    # More methods in /helpers/*
  end

  # Auto load app sub folder
  Dir[settings.root + '/app/helpers/*.rb', settings.root + '/app/models/*.rb'].each do |path|
    require path
  end

  ########################################################################
  # Routes/Controllers
  ########################################################################

  def protect_with_http_auth!
    protected!(settings.config["http_auth_username"], settings.config["http_auth_password"])
  end

  # ----------------------------------------------------------------------
  # Main
  # ----------------------------------------------------------------------

  get '/css/style.css' do
    content_type 'text/css', :charset => 'utf-8'
    scss :'sass/style'
  end

  get '/' do
    @page_name = "home"
    haml :index, :layout => :'layouts/application'
  end


  # -----------------------------------------------------------------------
  # Error handling
  # -----------------------------------------------------------------------

  not_found do
    logger.info "not_found: #{request.request_method} #{request.url}"
  end

  # All errors
  error do
    @page_name = "error"
    @is_error = true
    haml :error, :layout => :'layouts/application'
  end

end

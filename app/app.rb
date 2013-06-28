# encoding utf-8

require 'sinatra/base'
require 'sinatra/flash'
require 'sass'
require 'haml'
require 'yaml'

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

  # Helpers
  Dir[settings.root + '/app/helpers/*.rb'].each { |path| require path }

  helpers do
    include Rack::Utils
    alias_method :h, :escape_html

    include Sinatra::HttpAuthentication
  end

  # Auto load app sub folder
  Dir[settings.root + '/app/models/*.rb'].each do |path|
    require path
  end

  ########################################################################
  # Routes/Controllers
  ########################################################################

  # ----------------------------------------------------------------------
  # Main
  # ----------------------------------------------------------------------

  get '/css/style.css' do
    content_type 'text/css', :charset => 'utf-8'
    scss :'sass/style'
  end

  get '/' do
    protect_with_http_auth!

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

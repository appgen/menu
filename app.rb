require 'rubygems'
require 'bundler'
require 'erb'
require 'open-uri'

Bundler.require

Dir.glob('./lib/*.rb') do |model|
  require model
end

SEEDS = MultiJson.decode(open('http://comestibles.appgen.me/index.json').read)

class BigApp < Sinatra::Application

  configure do
    set :root, File.dirname(__FILE__)
    set :public_folder, Proc.new { File.join(root, "public") }

    Compass.configuration do |config|
      config.project_path = File.dirname(__FILE__)
      config.sass_dir = 'views'
    end

    set :haml, { :format => :html5 }
    set :sass, Compass.sass_engine_options
    set :scss, Compass.sass_engine_options
    set :public_folder, 'public'
  end

  before do
    if params[:seed]
      seed = params[:seed]
    else
      seed = SEEDS.sample
    end
    @app = FakeApp.new(seed)
  end

  after do
  # response.headers['Server'] = @app.server
  end

  get "/a/?" do
    haml File.read("views/boilerplates/#{@app.boilerplate}/index.haml"), :layout => :app_layout
  end

  get '/a/map/?' do
    haml File.read("views/boilerplates/#{@app.boilerplate}/map.haml"), :layout => :app_layout
  end

  get '/a/info/?' do
    haml File.read("views/boilerplates/#{@app.boilerplate}/info.haml"), :layout => :app_layout
  end

  get '/a/contact/?' do
    haml File.read("views/boilerplates/#{@app.boilerplate}/contact.haml"), :layout => :app_layout
  end

  get "/a/stylesheet.css" do
    response['Content-Type'] = 'text/css'
    erb File.read("views/boilerplates/#{@app.boilerplate}/stylesheet.erb")
  end

  get "/bootstrap.css" do
    File.readbootstrap.css
  end

  get "/" do
    haml :splash, :layout => :admin_layout
  end

  get "/browse/?" do
    haml :browse, :layout => :admin_layout
  end

  get "/audit/?" do
    haml :audit, :layout => :admin_layout
  end

  get "/audit/report/?" do
    haml :report, :layout => :admin_layout
  end

  def partial(haml_file)
    haml File.read(haml_file), :layout => false
  end
end

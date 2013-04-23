require 'rubygems'
require 'bundler'
require 'erb'

Bundler.require

Dir.glob('./lib/*.rb') do |model|
  require model
end

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
    pass if request.path_info.include? "submit"
    @seed = if params[:seed]
      params[:seed].to_i
    else
      rand(10000)
    end
    srand(@seed)
    @app = FakeApp.new
  end

  after do
    pass if request.path_info.include? "submit"
    response['Server'] = @app.server
  end

  get '/' do
    haml File.read("views/boilerplates/#{@app.boilerplate}/index.haml"), :layout => :app_layout
  end

  get '/map' do
    haml File.read("views/boilerplates/#{@app.boilerplate}/map.haml"), :layout => :app_layout
  end

  get '/info' do
    haml File.read("views/boilerplates/#{@app.boilerplate}/info.haml"), :layout => :app_layout
  end

  get '/contact' do
    haml File.read("views/boilerplates/#{@app.boilerplate}/contact.haml"), :layout => :app_layout
  end

  get "/stylesheet.css" do
    response['Content-Type'] = 'text/css'
    erb File.read("views/boilerplates/#{@app.boilerplate}/stylesheet.erb")
  end

  get "/bootstrap.css" do
    File.readbootstrap.css
  end

  get "/submit" do
    haml File.read("views/submission/index.haml"), :layout => :admin_layout
  end

  def partial(haml_file)
    haml haml_file, :layout => false
  end
end

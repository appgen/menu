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

  SEEDS = ['8073394527597018350']
  before do
    @fakeapp = FakeApp.new(SEEDS[0])
  end

  #after do
  #  pass if request.path_info.include? "submit"
  #  response['Server'] = @fakeapp.server
  #end

  get "/a/:seed" do
    haml File.read("views/boilerplates/#{@fakeapp.boilerplate}/index.haml"), :layout => :app_layout
  end

  get '/a/:seed/map' do
    haml File.read("views/boilerplates/#{@fakeapp.boilerplate}/map.haml"), :layout => :app_layout
  end

  get '/a/:seed/info' do
    haml File.read("views/boilerplates/#{@fakeapp.boilerplate}/info.haml"), :layout => :app_layout
  end

  get '/a/:seed/contact' do
    haml File.read("views/boilerplates/#{@fakeapp.boilerplate}/contact.haml"), :layout => :app_layout
  end

  get "/a/:seed/stylesheet.css" do
    response['Content-Type'] = 'text/css'
    erb File.read("views/boilerplates/#{@fakeapp.boilerplate}/stylesheet.erb")
  end

  get "/bootstrap.css" do
    File.readbootstrap.css
  end

  get "/" do
    haml :splash, :layout => :admin_layout
  end

  get "/browse" do
    haml :browse, :layout => :admin_layout
  end

  get "/audit" do
    haml :audit, :layout => :admin_layout
  end

  get "/audit/report" do
    haml :report, :layout => :admin_layout
  end

  def partial(haml_file)
    haml File.read(haml_file), :layout => false
  end
end

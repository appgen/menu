require 'open-uri'

class FakeApp 
  attr_accessor :font, :server, :zooms, :boilerplate, :tile_set, :navbar, :jquerytheme, :colors, :bootstraptheme, :kendotheme, :foundationtheme,
                :name, :collabfinder_need, :collabfinder_what, :collabfinder_why, :combined_title, :keywords, :sources, :source_ids,
                :seed, :csv, :json, :geojson

  TILE_LAYERS = ["'http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {attribution: 'OpenStreetMap'}",
                  "'http://otile{s}.mqcdn.com/tiles/1.0.0/{type}/{z}/{x}/{y}.png', {subdomains: '1234', type: 'osm', attribution: 'MapQuestOpen'}",
                  "'http://otile{s}.mqcdn.com/tiles/1.0.0/{type}/{z}/{x}/{y}.png', {subdomains: '1234', type: 'sat', attribution: 'MapQuestOpen'}",
                  '"http://{s}.tile.opencyclemap.org/cycle/{z}/{x}/{y}.png", {attribution: "OpenCycleMap"}',
                  "'http://tile.stamen.com/toner/{z}/{x}/{y}.png', {attribution: 'Stamen Toner'}",
                  "'http://tile.stamen.com/watercolor/{z}/{x}/{y}.png', {attribution: 'Stamen Watercolor'}",
                  "'http://tile.stamen.com/terrain/{z}/{x}/{y}.png', {attribution: 'Stamen Terrain'}"
  ]
  SERVERS = [
    "Server:Apache/2.2.14 (Unix) mod_ssl/2.2.14 OpenSSL/0.9.8e-fips-rhel5 DAV/2 mod_auth_passthrough/2.1 mod_bwlimited/1.4 FrontPage/5.0.2.2635",
    "Apache/2.2",
    "GitHub.com",
    "Apache",
    "nginx/1.0.0",
    "Microsoft-IIS/7.5",
    "Apache/2.4.4 (Unix) OpenSSL/1.0.0g",
  ]
  ZOOMS=(3..21).to_a
  BOILERPLATES = ["bootstrap", "jquerymobile", "kendoui", "foundation"]
  FONTS = ["Lobster", "Raleway","Lato","Oleo Script","Special Elite","Fredoka One","Josefin Slab","Arvo","Open Sans","Vollkorn","Abril Fatface","Ubuntu","PT Sans","Old Standard TT","Droid Sans"]
  PATTERNS = ["img/bg_stripe.png", "img/bg_square.png"]
  NAV = ["navbar-fixed", "navbar-fixed navbar-inverse", "navbar-inverse", ""]
  JQUERYTHEME = ["a", "b", "c", "d", "e"]
  BOOTSTRAPTHEME = ["amelia", "bootstrap", "cerulean", "cosmo", "cyborg", "journal", "readable", "simplex", "slate", "spacelab", "spruce", "superhero", "united"]
  KENDOTHEME = ["black", "blueopal", "bootstrap", "default", "highcontrast", "metro", "metroblack", "moonlight", "rtl", "silver", "uniform"]
  FOUNDATIONTHEME = ["default", "evergreen", "coffeenmilk", "bladesofsteel"]

  def initialize(seed)
    @seed = seed
    srand(@seed.to_i) # set seed

    # Aesthetic
    @boilerplate = BOILERPLATES.sample
    @server = SERVERS.sample
    @tile_set = TILE_LAYERS.sample
    @zooms = (ZOOMS.sample 2).sort
    @font = FONTS.sample
    @navbar = "navbar " + NAV.sample
    @jquerytheme = JQUERYTHEME.sample
    @colors = getRandomColor
    @bootstraptheme = BOOTSTRAPTHEME.sample
    @kendotheme = KENDOTHEME.sample
    @foundationtheme = FOUNDATIONTHEME.sample

    # Data file
    # basename = File.join('comestibles', @seed)
    basename = 'http://comestibles.appgen.me/' + @seed

    # File paths
    @csv = basename + '.csv'
    @json = basename + '.json'
    @geojson = basename + '.geojson'

    # Data-based app parameters
    metadata = MultiJson.decode(open("#{basename}.json").read)

    # Pre-aggregated data stuff
    @name = metadata['name']
    @collabfinder_need = metadata['collabfinder_need']
    @collabfinder_what = metadata['collabfinder_what']
    @collabfinder_why = metadata['collabfinder_why']
    @combined_title = metadata['combined_title']
    @keywords = metadata['keywords']

    # Source datasets
    @sources = metadata['sources']
    @source_ids = @sources.map { |view| view['id'] }
  end

  def getRandomColor
    color1 = "#" + "%06x" % (rand * 0xffffff)
    color2 = "#" + "%06x" % (rand * 0xffffff)
    color3 = "#" + "%06x" % (rand * 0xffffff)
    [color1, color2, color3]
  end

  def getKeyword
    @keywords.sample
  end

end

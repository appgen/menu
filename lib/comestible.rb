class Comestible
  attr_accessor :json_obj, :map_obj
  def initialize(seed)
    @seed = seed
    basename = File.join('comestibles', seed)
    metadata = MultiJson.decode(File.open("#{basename}.json", 'r').read)

    # Pre-aggregated stuff
    @name = metadata['name']
    @collabfinder_need = metadata['collabfinder_need'],
    @collabfinder_what = metadata['collabfinder_what'],
    @collabfinder_why = metadata['collabfinder_why'],
    @combined_title = metadata['combined_title'],
    @keywords = metadata['keywords']

    # Source datasets
    @sources = metadata['sources'],
    @source_ids = @sources.map { |view| view['id'] }

  end
end

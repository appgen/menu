class Audit
  attr_accessor :json_obj

  def self.load
    Audit.new()
  end

  def initialize
    json_txt = Audit.load_file
    @json_obj = MultiJson.decode(json_txt)
  end

  private

  def self.load_file
    filename = File.join('data', "unionable.json")
    File.open(filename, 'r').read
  end
end
class Audit
  attr_accessor :json_obj, :depts

  def self.load
    Audit.new()
  end

  def initialize
    json_txt = Audit.load_file
    @json_obj = MultiJson.decode(json_txt)
    @depts = []
    @json_obj.each do |superset|
      if !@depts.index(superset["datasets"][0]["attribution"])
        @depts.push(superset["datasets"][0]["attribution"])
      end
    end
  end

  def count_datasets(dept)
    count = 0
    @json_obj.each do |superset|
      superset["datasets"].each do |set|
        if set["attribution"] == dept
          count = count + 1
        end
      end
    end
    return count
  end

  def count_supersets(dept)
    count = 0
    @json_obj.each do |superset|
      if superset["datasets"][0]["attribution"] == dept
        count = count + 1
      end
    end
    return count
  end

  private

  def self.load_file
    filename = File.join('data', "unionable.json")
    File.open(filename, 'r').read
  end

end
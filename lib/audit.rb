class Audit
  attr_accessor :json_obj

  def self.load
    Audit.new()
  end

  def initialize
    json_txt = Audit.load_file
    @json_obj = MultiJson.decode(json_txt)
  end

  def departments
    depts = Hash.new
    @json_obj.each do |superset|
      superset["datasets"].each do |set|
        if depts.include?(set["attribution"])
          depts[set["attribution"]] = depts[set["attribution"]] + 1
        else
          depts[set["attribution"]] = 1
        end
      end
    end
    return depts
  end

  def datasets(dept)
    count = 0;
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
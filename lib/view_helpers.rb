class AboutPresenter
  def initialize(dataset)
    @dataset = dataset
  end
  
  def getDataDescription
    @dataset.json_obj["description"]
  end

  def getDataName
    @dataset.json_obj["name"]
  end

  def getDataCategory
    @dataset.json_obj["category"]
  end

  def getDataTag
    @dataset.json_obj["tags"].sample
  end

end

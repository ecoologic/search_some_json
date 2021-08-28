class Models::Query
  @@cache = {}

  def self.all_for(model)
    @@cache[model] ||= JSON.parse(File.read("./data/#{model}.json"), symbolize_names: true)
  end

  def self.find(model, id)
    id_i = id.to_i
    record = all_for(model).find { |record| record[:_id] == id_i }
    record[:name]
  end

  def initialize(model)
    @model = model
  end

  def select(field, text)
    self.class.all_for(model).select do |record|
      record[field].to_s == text
    end
  end

  private

  attr_reader :model
end

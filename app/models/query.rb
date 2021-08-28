class Models::Query
  @@cache = {}

  def initialize(model)
    @model = model
  end

  def all
    @@cache[model] ||= JSON.parse(File.read("./data/#{model}.json"), symbolize_names: true)
  end

  def select(field, text)
    all.select do |record|
      record[field].to_s == text
    end
  end

  def find(id)
    id_i = id.to_i
    record = all.find { |record| record[:_id] == id_i }
    record[:name]
  end

  private

  attr_reader :model
end

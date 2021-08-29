class SelectionDatabase
  @@cache = {}

  def initialize(model_type, field, query)
    @model_type, @field, @query = model_type, field, query
  end

  def all
    @@cache[model_type] ||= JSON.parse(File.read("./data/#{model_type}.json"), symbolize_names: true)
  end

  def matching_records
    @matching_records ||= all.select do |record|
      record[field].to_s == query
    end
  end

  def decorated_records
    @decorated_records = matching_records
  end

  # def find(id)
  #   id_i = id.to_i
  #   record = all.find { |record| record[:_id] == id_i }
  #   record[:name]
  # end

  private

  attr_reader :model_type, :field, :query
end

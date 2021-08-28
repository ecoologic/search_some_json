class Query
  def initialize(model)
    # TODO: parse errors
    @records = JSON.parse(File.read("./data/#{model}.json"), symbolize_names: true)
  end

  def where(field, text)
    records.select do |record|
      record[field.to_sym].to_s == text
    end
  end

  private

  attr_reader :records
end

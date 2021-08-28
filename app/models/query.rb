class Models::Query
  def initialize(model)
    @model = model
  end

  def select(field, text)
    Models::Database.all_for(model).select do |record|
      record[field].to_s == text
    end
  end

  private

  attr_reader :model
end

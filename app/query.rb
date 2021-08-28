# TODO? in models?
class Query
  def initialize(model)
    @model = model
  end

  # TODO: select?
  def where(field, text)
    Models::Database.all_for(model).select do |record|
      record[field.to_sym].to_s == text
    end
  end

  private

  attr_reader :model
end

module SearchController
  # TODO: extract
  DECORATOR_BY_MODEL = {
    users: Models::Users::Decorator
  }

  def self.call(input = Input.new, output = Output)
    matching_records = Query.new(input.model)
      .where(input.field, input.query)

    decorator_class = decorator_class_for(input.model)
    decorated_records = matching_records.map { |r| decorator_class.new(r).call }

    output.table(decorated_records)
  end

  # TODO: remove?
  def self.decorator_class_for(model)
    DECORATOR_BY_MODEL[model.to_sym]
  end
end

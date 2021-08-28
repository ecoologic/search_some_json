module SearchController
  # TODO: extract
  DECORATOR_BY_MODEL = {
    users: Models::Users::Decorator
  }

  def self.call(input = Input.new, output = Output)
    matching_records = Models::Query.new(input.model)
      .select(input.field, input.query)

    decorated_records = matching_records.map do |record|
      DECORATOR_BY_MODEL[input.model].new(record).call
    end

    output.table(decorated_records)
  end
end

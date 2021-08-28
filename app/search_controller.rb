module SearchController
  # TODO: extract
  MODEL_BY_TYPE = {
    users: Models::Users::Decorator
  }

  def self.call(input = Input.new, output = Output)
    matching_records = Models::Query.new(input.model_type)
      .select(input.field, input.query)

    decorated_records = matching_records.map do |record|
      MODEL_BY_TYPE[input.model_type].new(record).call
    end

    output.table(decorated_records)
  end
end

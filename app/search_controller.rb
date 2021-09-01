# frozen_string_literal: true

module SearchController
  def self.call(input = Input.new, output = Output)
    matching_records = ModelDatabase.matching_records(
      input.model_type,
      input.field,
      input.query
    )

    decorated_records = matching_records.map do |record|
      Models::BY_TYPE[input.model_type]
        .new(record)
        .decorated_record
    end

    output.table(decorated_records)
  end
end

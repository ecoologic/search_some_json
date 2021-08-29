module SearchController
  def self.call(input = Input.new, output = Output)
    db = SelectionDatabase.new(
      input.model_type,
      input.field,
      input.query
    )

    decorated_records = db.matching_records.map do |record|
      Models::BY_TYPE[input.model_type]
        .new(record)
        .decorated_record(db.associated_records)
    end

    output.table(decorated_records)
  end
end

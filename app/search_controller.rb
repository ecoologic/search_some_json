module SearchController
  def self.call(input = Input.new, output = Output)
    matching_records = Query.new(input.model)
      .where(input.field, input.query)
    output.table(matching_records)
  end
end

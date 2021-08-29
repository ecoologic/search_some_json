class SelectionDatabase
  @@cache = {}

  def initialize(model_type, field, query)
    @model_type, @field, @query = model_type, field, query
  end

  def all_model_records
    model_records_for(model_type)
  end

  def matching_records
    @matching_records ||= all_model_records.select do |record|
      record[field].to_s == query
    end
  end

  # Return all records, for all model types (files),
  # that are associated with the records that match your query
  #
  # This is done to avoid scanning the potentially big files multiple times
  #
  # Below, an example of the values you can find in these loops
  #
  # association_rules = {
  #   organizations: { _id: 111 },
  #   tickets: { submitter_id: 1, assignee_id: 1 }
  # }
  # model_type = :tickets
  # model_rules = { submitter_id: 1, assignee_id: 1 }
  # associated_records = { organizations: [record], tickets: [ticket] }
  def associated_records
    @associated_records ||= begin
      result = Hash.new([])
      # TODO: current_records at the top, use Models::BY_TYPE (check unex)
      matching_records.each do |matching_record|
        model_class.new(matching_record).association_rules.each do |(model_type, model_rules)|
          current_records = model_records_for(model_type)
          result[model_type] += current_records.select do |current_record|
            model_rules.find do |(field, value)|
              current_record[field] == value
            end
          end
        end
      end
      result
    end
  end

  private

  attr_reader :model_type, :field, :query

  def model_class
    Models::BY_TYPE[model_type]
  end

  def model_records_for(model_type)
    @@cache[model_type] ||=
      JSON.parse(File.read("./data/#{model_type}.json"), symbolize_names: true)
  rescue => e
    # Log(e)
    puts ERROR_MESSAGES[:cannot_load_file]
  end
end

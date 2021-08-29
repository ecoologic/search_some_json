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
  # model_type = :tickets
  # associated_records = { organizations: [org], tickets: [ticket] }
  # current_records = [record] # all records for the model in the current iteration
  def associated_records
    @associated_records ||= begin
      result = {}

      # For every (current) record in the (current) file
      Models::BY_TYPE.keys.each do |current_model_type|
        current_records = model_records_for(current_model_type)
        result[current_model_type] = current_records.select do |current_record|
          association_record?(current_model_type, current_record)
        end
      end
      result
    end
  end

  private

  attr_reader :model_type, :field, :query

  # Is this record worthy of being cached?
  # association_rules: *** SEE Models::User ***
  # matching_records = the records we will print in the results
  def association_record?(model_type, possible_record)
    matching_records.each do |matching_record|
      model = model_class.new(matching_record)
      model.association_rules[model_type].to_a.each do |model_rules|
        model_rules.each do |(field, value)|
          return true if possible_record[field] == value
        end
      end
    end
    false
  end

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

class SelectionDatabase
  @@cache = {}

  # TODO: extract
  MODEL_BY_TYPE = {
    users: Models::User,
    organizations: Models::Organization,
    tickets: Models::Ticket
  }

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

  # TODO: explain
  # association_rules = {
  #   organizations: { _id: 111 },
  #   tickets: { submitter_id: 1, assignee_id: 1 }
  # }
  # model_type = :tickets
  # model_rules = { submitter_id: 1, assignee_id: 1 }
  # associated_records = { organizations: [record], tickets: [ticket] }
  def associated_records
    # TODO: @associated_records ||=
    result = Hash.new([])
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

  private

  attr_reader :model_type, :field, :query

  def model_class
    MODEL_BY_TYPE[model_type]
  end

  def model_records_for(model_type)
    @@cache[model_type] ||=
      JSON.parse(File.read("./data/#{model_type}.json"), symbolize_names: true)
  end
end

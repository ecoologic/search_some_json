class Models::Database
  @@cache = {}

  def initialize(model)
    @model = model
  end

  # TODO: instance!!!
  # TODO: parse errors
  def self.all_for(model)
    @@cache[model] ||= JSON.parse(File.read("./data/#{model}.json"), symbolize_names: true)
  end

  # TODO: same logic in query??
  def self.find(model, id)
    id_i = id.to_i
    record = all_for(model).find { |record| record[:_id] == id_i }
    record[:name]
  end

  def find_all
    # request = {
    #   tickets: { assignee_id: 1, submitter_id: 1 },
    #   organizations: { _id: 3 },
    # }
  end

  private

  attr_reader :model
end

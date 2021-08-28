class Models::Database
  @@cache = {}

  # TODO: instance!!!
  def self.all_for(model)
    # TODO: parse errors
    @@cache[model.to_sym] ||= JSON.parse(File.read("./data/#{model}.json"), symbolize_names: true)
  end

  def self.find(model, id)
    id_int = id.to_i
    record = all_for(model).find { |record| record[:_id] == id_int }
    record[:name]
  end
end

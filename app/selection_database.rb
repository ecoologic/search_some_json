# frozen_string_literal: true

class ModelDatabase
  @@cache = {}
  @@reverse_cache = {}

  def initialize(model_type)
    @model_type = model_type
    records_by_id
  end

  def records
    # TODO: uncached_records
    records_by_id.values
  end

  def records_by_id
    @@cache[model_type] ||= begin
      result = {}

      uncached_records.each do |record|
        next unless record[:_id]

        result[record[:_id]] = record

        reverse_cache(record)
      end
      result
    end
  end

  # Example: relation_records(:assignee, 1)
  def relation_records(relation, id)
    return [] if id.nil?

    @@reverse_cache[model_type].to_h[relation].to_h[id] || []
  end

  private

  attr_reader :model_type

  # Values example:
  # user: { _id: 1 }
  # ticket: { _id: 22, assignee_id: 1 }
  # @@reverse_cache: { tickets: { assignee: { 1 => [22] } } }
  # unassigned values: { tickets: { assignee: { nil => [33, 44] } } }
  #
  # Note: Could be optimised by stoging to the position in the original json, instead of the whole object
  #       unassigned values could not be stored
  def reverse_cache(record)
    @@reverse_cache ||= {}
    @@reverse_cache[model_type] ||= {}

    if model_type == :tickets
      @@reverse_cache[model_type][:assignee] ||= {}
      @@reverse_cache[model_type][:assignee][record[:assignee_id]] ||= []
      @@reverse_cache[model_type][:assignee][record[:assignee_id]] << record

      @@reverse_cache[model_type][:submitter] ||= {}
      @@reverse_cache[model_type][:submitter][record[:submitter_id]] ||= []
      @@reverse_cache[model_type][:submitter][record[:submitter_id]] << record
    end
  end

  def uncached_records
    JSON.parse(File.read("./data/#{model_type}.json"), symbolize_names: true)
  rescue StandardError => e
    # Log(e)
    puts ERROR_MESSAGES[:cannot_load_file]
    []
  end
end

# TODO: module, SearchDatabase, QueryDatabase
class SelectionDatabase
  def initialize(model_type, field, query)
    @model_type = model_type
    @field = field
    @query = query
  end

  def matching_records
    @matching_records ||= ModelDatabase.new(model_type).records.select do |record|
      record[field].to_s == query
    end
  end

  private

  attr_reader :model_type, :field, :query
end

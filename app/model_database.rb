# frozen_string_literal: true

class ModelDatabase
  @@cache = {}
  @@reverse_cache = {}

  def self.matching_records(model_type, field, query)
    new(model_type).records.select do |record|
      record[field].to_s == query
    end
  end

  def initialize(model_type)
    @model_type = model_type
    records_by_id
  end

  def records
    records_by_id.values
  end

  # Example: @@cache = { users: { 1 => { _id: 1, ... } } }
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
    @@reverse_cache[model_type].to_h[relation].to_h[id] || []
  end

  private

  attr_reader :model_type

  # Values example:
  # user1: { _id: 1, ... }
  # ticket22: { _id: 22, assignee_id: 1, ... }
  # @@reverse_cache: { tickets: { assignee: { 1 => [ticket22] } } }
  # TODO: only store user ids
  def reverse_cache(record)
    if model_type == :tickets
      @@reverse_cache[:tickets] ||= {}

      @@reverse_cache[:tickets][:assignee] ||= {}
      @@reverse_cache[:tickets][:assignee][record[:assignee_id]] ||= []
      @@reverse_cache[:tickets][:assignee][record[:assignee_id]] << record if record[:assignee_id]

      @@reverse_cache[:tickets][:submitter] ||= {}
      @@reverse_cache[:tickets][:submitter][record[:submitter_id]] ||= []
      @@reverse_cache[:tickets][:submitter][record[:submitter_id]] << record if record[:submitter_id]
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

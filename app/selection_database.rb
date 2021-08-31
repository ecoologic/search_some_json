# frozen_string_literal: true

class SelectionDatabase
  def initialize(model_type, field, query)
    @model_type = model_type
    @field = field
    @query = query
  end

  def all_model_records
    model_records_for(model_type)
  end

  def matching_records
    @matching_records ||= all_model_records.select do |record|
      record[field].to_s == query
    end
  end

  # Example: records_by_id[:organizations][101][:name]
  def records_by_id
    @records_by_id ||= begin
      result = {}

      # For every (current) record in the (current) file
      Models::BY_TYPE.each_key do |current_model_type|
        current_records = model_records_for(current_model_type)
        current_records.each do |current_record|
          result[current_model_type] ||= {}
          result[current_model_type][current_record[:_id]] = current_record
          cache_reverse_associations(current_model_type, current_record)
        end
      end
      result
    end
  end

  # Example: records_for_id(:tickets, :assignee, 1)
  def records_for_id(model_type, relation, id)
    return [] if id.nil?

    @reverse_cache[model_type].to_h[relation].to_h[id] || []
  end

  private

  attr_reader :model_type, :field, :query

  # Values example:
  # user: { _id: 1 }
  # ticket: { _id: 22, assignee_id: 1 }
  # @reverse_cache: { tickets: { assignee: { 1 => [22] } } }
  # unassigned values: { tickets: { assignee: { nil => [33, 44] } } }
  #
  # Note: Could be optimised by stoging to the position in the original json, instead of the whole object
  #       unassigned values could not be stored
  def cache_reverse_associations(foreign_model_type, foreign_record)
    @reverse_cache ||= {}
    @reverse_cache[foreign_model_type] ||= {}

    if foreign_model_type == :tickets
      @reverse_cache[foreign_model_type][:assignee] ||= {}
      @reverse_cache[foreign_model_type][:assignee][foreign_record[:assignee_id]] ||= []
      @reverse_cache[foreign_model_type][:assignee][foreign_record[:assignee_id]] << foreign_record

      @reverse_cache[foreign_model_type] ||= {}
      @reverse_cache[foreign_model_type][:submitter] ||= {}
      @reverse_cache[foreign_model_type][:submitter][foreign_record[:submitter_id]] ||= []
      @reverse_cache[foreign_model_type][:submitter][foreign_record[:submitter_id]] << foreign_record
    end
  end

  def model_records_for(model_type)
    JSON.parse(File.read("./data/#{model_type}.json"), symbolize_names: true)
  rescue StandardError => e
    # Log(e)
    puts ERROR_MESSAGES[:cannot_load_file]
    []
  end
end

# frozen_string_literal: true

module Models
  class User < Models::Base
    def decorated_record
      record.merge(
        organization_name: ModelDatabase.new(:organizations).records_by_id[record[:organization_id]].to_h[:name],
        assigned_ticket_subjects: ModelDatabase.new(:tickets).relation_records(:assignee, record[:_id]).map { |r| r[:subject] },
        submitter_ticket_subjects: ModelDatabase.new(:tickets).relation_records(:submitter, record[:_id]).map { |r| r[:subject] }
      )
    end
  end
end

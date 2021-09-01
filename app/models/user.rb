# frozen_string_literal: true

module Models
  class User < Models::Base
    def decorated_record
      record.merge(
        organization_name: organization_name,
        assigned_ticket_subjects: assigned_ticket_subjects,
        submitter_ticket_subjects: submitter_ticket_subjects
      )
    end

    private

    def organization_name
      ModelDatabase
        .new(:organizations)
        .records_by_id[record[:organization_id]]
        .to_h[:name]
    end

    def assigned_ticket_subjects
      ModelDatabase
        .new(:tickets)
        .relation_records(:assignee, record[:_id])
        .map { |r| r[:subject] }
    end

    def submitter_ticket_subjects
      ModelDatabase
        .new(:tickets)
        .relation_records(:submitter, record[:_id])
        .map { |r| r[:subject] }
    end
  end
end

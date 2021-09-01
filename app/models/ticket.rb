# frozen_string_literal: true

module Models
  class Ticket < Models::Base
    def decorated_record
      record.merge(
        organization_name: organization_name,
        submitter_name: submitter_name,
        assignee_name: assignee_name
      )
    end

    private

    def organization_name
      ModelDatabase
        .new(:organizations)
        .records_by_id[record[:organization_id]]
        .to_h[:name]
    end

    def submitter_name
      ModelDatabase
        .new(:users)
        .records_by_id[record[:submitter_id]]
        .to_h[:name]
    end

    def assignee_name
      ModelDatabase
        .new(:users)
        .records_by_id[record[:assignee_id]]
        .to_h[:name]
    end
  end
end

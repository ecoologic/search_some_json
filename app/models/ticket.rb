# frozen_string_literal: true

module Models
  class Ticket < Models::Base
    def decorated_record
      record.merge(
        organization_name: ModelDatabase.new(:organizations)
                                        .records_by_id[record[:organization_id]]
                                        .to_h[:name],
        submitter_name: ModelDatabase.new(:users)
                                     .records_by_id[record[:submitter_id]]
                                     .to_h[:name],
        assignee_name: ModelDatabase.new(:users)
                                    .records_by_id[record[:assignee_id]]
                                    .to_h[:name]
      )
    end
  end
end

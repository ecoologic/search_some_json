# frozen_string_literal: true

module Models
  class Ticket < Models::Base
    def decorated_record(db)
      record.merge(
        organization_name: db.records_by_id[:organizations].to_h[record[:organization_id]].to_h[:name],
        submitter_name: db.records_by_id[:users].to_h[record[:submitter_id]].to_h[:name],
        assignee_name: db.records_by_id[:users].to_h[record[:assignee_id]].to_h[:name]
      )
    end
  end
end

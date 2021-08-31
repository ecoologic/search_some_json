class Models::User < Models::Base
  def decorated_record(db)
    record.merge(
      organization_name: db.records_by_id[:organizations].to_h[record[:organization_id]].to_h[:name],
      assigned_ticket_subjects: db.records_for_id(:tickets, :assignee, record[:_id]).map { |r| r[:subject] },
      submitter_ticket_subjects: db.records_for_id(:tickets, :submitter, record[:_id]).map { |r| r[:subject] }
    )
  end
end

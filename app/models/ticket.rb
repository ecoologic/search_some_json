class Models::Ticket < Models::Base
  def decorated_record(associated_records)
    record
      .merge(organization_name: associated_value(
        associated_records[:organizations],
        field: :organization_id,
      ))
      .merge(assignee_name: associated_value(
        associated_records[:users],
        field: :assignee_id,
      ))
      .merge(submitter_name: associated_value(
        associated_records[:users],
        field: :submitter_id,
      ))
  end

  def association_rules
    {
      organizations: [[:_id, record[:organization_id]]],
      users: [[:_id, record[:submitter_id]], [:_id, record[:assignee_id]]]
    }
  end
end

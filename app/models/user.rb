class Models::User < Models::Base
  def decorated_record(associated_records)
    record
      .merge(organization_name: associated_value(
        associated_records[:organizations],
        field: :organization_id,
      ))
      .merge(assigned_ticket_subjects: associated_values(
        associated_records[:tickets],
        associated_field: :assignee_id,
        returning: :subject
      ))
      .merge(submitted_ticket_subjects: associated_values(
        associated_records[:tickets],
        associated_field: :submitter_id,
        returning: :subject
      ))
  end

  def association_rules
    {
      organizations: [[:_id, record[:organization_id]]],
      tickets: [[:submitter_id, record[:_id]], [:assignee_id, record[:_id]]]
    }
  end
end

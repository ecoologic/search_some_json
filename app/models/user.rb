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
      # I want the organization with the ID of this record
      organizations: [[:_id, record[:organization_id]]],
      tickets: [
        # I want the ticket with submitter_id == this record ID
        [:submitter_id, record[:_id]],
        [:assignee_id, record[:_id]]]
    }
  end
end

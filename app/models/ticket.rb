class Models::Ticket
  def initialize(record)
    @record = record
  end

  def decorated_record(ars)
    record
      .merge(organization_name:
        ars[:organizations].find { |r| r[:_id] == record[:organization_id] }[:name])
      .merge(assignee_name: ars[:users].find { |r| r[:_id] == record[:assignee_id] }[:name])
    # TODO: submitter
  end

  def association_rules
    {
      organizations: { _id: record[:organization_id] },
      # TODO: make [:_id, 123]
      users: { _id: record[:submitter_id], _id: record[:assignee_id] }
    }
  end

  private

  attr_reader :record
end

# NOTE: Would be better named Presenter
class Models::Users::Decorator
  DISPLAY_FIELD = :name # TODO: or name || subject

  def initialize(record)
    @record = record
  end

  def call
    record
      .merge(organization_name: organization_name)
      .merge(assigned_tickets)
      # .except(:organization_id) # Only available in Ruby3
  end

  private

  attr_reader :record

  def organization_name
    Models::Query.new(:organizations).find(record[:organization_id])
  end

  def assigned_tickets
    # Models::Database.select(:tickets, :assignee_id, 11)
    {}
  end
end

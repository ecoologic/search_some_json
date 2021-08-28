# TODO: presenter
class Models::Users::Decorator
  def initialize(record)
    @record = record
  end

  def call
    record
      .merge(organization_name: organization_name)
      # .except(:organization_id) # TODO: ruby3
  end

  private

  attr_reader :record

  def organization_name
    Models::Database.find(:organizations, record[:organization_id])
  end
end

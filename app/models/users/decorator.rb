# TODO: presenter
class Models::Users::Decorator
  def initialize(record)
    @record = record
  end

  def call
    record
      .merge(organisation_name: organisation_name)
      # .except(:organisation_id) # TODO: ruby3
  end

  private

  attr_reader :record

  def organisation_name
    "Multron MOCKED"
  end
end

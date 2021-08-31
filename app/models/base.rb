class Models::Base
  def initialize(record)
    @record = record
  end

  def decorated_record(_db)
    record
  end

  def association_rules
    {}
  end

  private

  attr_reader :record
end

class Models::User
  def initialize(record)
    @record = record
  end

  def decorated_record
    record
  end

  private

  attr_reader :record
end

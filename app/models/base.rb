class Models::Base
  def initialize(record)
    @record = record
  end

  def decorated_record(_associated_records)
    record
  end

  def association_rules
    {}
  end

  private

  attr_reader :record

  def associated_value(model_records, field: :_id, associated_field: :_id, returning: :name)
    associated = model_records.find { |r| r[associated_field] == record[field] }
    associated[returning]
  rescue => e
    # Log(e)
    puts ERROR_MESSAGES[:missing_association]
    N_A
  end

  def associated_values(model_records, field: :_id, associated_field: :_id, returning: :name)
    associated = model_records.select { |r| r[associated_field] == record[field] }
    associated.map { |a| a[returning] }
  rescue => e
    puts ERROR_MESSAGES[:missing_association]
    N_A
  end
end

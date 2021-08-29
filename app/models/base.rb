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

  def associated_value(model_records, field:, associated_field:, returning: :name)
    associated = model_records.find { |r| r[associated_field] == record[field] }
    associated[returning]
    # TODO: catch
  end

  def associated_values(model_records, field:, associated_field:, returning: :name)
    associated = model_records.select { |r| r[associated_field] == record[field] }
    associated.map { |a| a[returning] }
    # TODO: catch
  end
end

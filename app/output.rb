module Output
  TABLE_COLUMN_SIZE = 30

  def self.table(records)
    printable = records.map do |record|
      ["\n"] + record.keys.map do |field|
        space_count = TABLE_COLUMN_SIZE - field.to_s.size
        spaces = ' ' * space_count
        [field, spaces, record[field]].join
      end
    end

    printable.each { |line| puts line }
  end
end

# frozen_string_literal: true

module Models
  class Base
    def initialize(record)
      @record = record
    end

    def decorated_record
      record
    end

    private

    attr_reader :record
  end
end

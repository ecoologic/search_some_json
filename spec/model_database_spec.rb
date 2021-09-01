# frozen_string_literal: true

describe ModelDatabase do
  describe '.matching_records' do
    it "returns an empty list when the file can't be read" do
      actual = described_class.matching_records(:unexistings, :field, 'query')

      expect(actual).to be_empty
    end
  end
end

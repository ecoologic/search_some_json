describe SelectionDatabase do
  describe '#all_model_records' do
    it "returns nil when the file can't be read" do
      subject = described_class.new(:unexistings, :field, 'query')

      actual = subject.all_model_records

      expect(actual).to be(nil)
    end
  end
end

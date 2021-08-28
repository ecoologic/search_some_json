describe SearchController do
  describe '.call' do
    it "returns a list of users" do
      actual = described_class.call

      expect(actual.size).to eq(1)
      expect(actual.first.size).to eq(20)
      expect(actual.first[4]).to match(/name\s+Francisca Rasmussen/i)
    end
  end
end

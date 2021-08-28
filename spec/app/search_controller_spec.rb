describe SearchController do
  let(:input) { double(:input, model: 'users', field: 'alias', query: 'Mr Ola') }
  describe '.call' do
    it "returns a list of users" do
      actual = described_class.call(input)

      expect(actual.size).to eq(1)
      expect(actual.first.size).to eq(20)
      expect(actual.first[4]).to match(/name\s+Loraine Pittman/i)
    end
  end
end

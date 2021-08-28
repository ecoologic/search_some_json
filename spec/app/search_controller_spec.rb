describe SearchController do
  let(:input) { double(:input, model: 'users', field: 'alias', query: 'Mr Ola') }
  describe '.call' do
    describe "when I select a user" do
      it "returns a list of matching users with their organisation name" do
        actual = described_class.call(input)

        expect(actual.size).to eq(1)
        expect(actual.first.size).to eq(21)
        expect(actual.first[4]).to match(/name\s+Loraine Pittman/i)
        expect(actual.first[20]).to match(/organisation_name\s+Multron MOCKED/)
      end
    end
  end
end

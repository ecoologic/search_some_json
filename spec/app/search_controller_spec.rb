describe SearchController do
  let(:input) { double(:input, model: 'users', field: 'alias', query: 'Mr Ola') }
  describe '.call' do
    describe "when I select a user" do
      it "returns a list of matching users with their organization name" do
        actual = described_class.call(input)

        expect(actual.size).to eq(1)
        expect(actual.first.size).to eq(21)
        expect(actual.first[4]).to match(/name\s+Loraine Pittman/i)
        expect(actual.first[20]).to match(/organization_name\s+Enthaze$/)
      end
    end
  end
end

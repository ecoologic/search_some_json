describe SearchController do
  let(:input) { double(:input, model_type: :users, field: :alias, query: 'Mr Ola') }
  describe '.call' do
    describe "when I select a user" do
      it "returns a list of matching users with associated records" do
        actual = described_class.call(input)

        expect(actual.size).to eq(1)
        expect(actual.first.size).to eq(20)
        # NOTE: Using index might be temperamental (haven't experienced yet)
        expect(actual.first[4]).to match(/^name\s+Loraine Pittman$/i)
        expect(actual.first[17]).to match(/^tags\s+Frizzleburg, Forestburg, Sandston, Delco$/)
        # expect(actual.first[20]).to match(/^organization_name\s+Enthaze$/)
      end
    end
  end
end

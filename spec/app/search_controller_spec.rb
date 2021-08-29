describe SearchController do
  describe '.call' do
    describe "when I select a user" do
      let(:input) { double(:input, model_type: :users, field: :alias, query: 'Mr Ola') }

      it "returns a list of matching users with associated records" do
        actual = described_class.call(input)

        expect(actual.size).to eq(1)
        expect(actual.first.size).to eq(22)
        # NOTE: Using index might be temperamental (haven't experienced yet)
        expect(actual.first[4]).to match(/^name\s+Loraine Pittman$/i)
        expect(actual.first[17]).to match(/^tags\s+Delco; Forestburg; Frizzleburg; Sandston$/)
        expect(actual.first[20]).to match(/^organization_name\s+Enthaze$/)
        expect(actual.first[21])
          .to match(/^assigned_ticket_subjects\s+A Drama in Botswana; A Drama in Cameroon; A Drama in Gabon; A Drama in Saudi Arabia$/)
      end
    end

    describe "when I select an organization" do
      let(:input) { double(:input, model_type: :organizations, field: :_id, query: '103') }

      it "returns a list of matching users with associated records" do
        actual = described_class.call(input)

        expect(actual.size).to eq(1)
        expect(actual.first.size).to eq(10)
        expect(actual.first[4]).to match(/^name\s+Plasmos$/i)
        expect(actual.first[5]).to match(/^domain_names\s+automon.com; comvex.com; gogol.com; verbus.com$/)
        expect(actual.first[9]).to match(/^tags\s+Armstrong; Lindsay; Parrish; Vaughn$/)
      end
    end
  end

  # TODO: multiple results
end

describe SearchController do
  describe '.call' do
    describe "when I select a user" do
      let(:input) { double(:input, model_type: :users, field: :alias, query: 'Mr Ola') }

      it "returns a list of matching users with associated records" do
        actual = described_class.call(input)

        expect(actual.size).to eq(1)
        expect(actual.first.size).to eq(23)
        expect(actual.first.join("\n")).to match(/^name\s+Loraine Pittman$/i)
        expect(actual.first.join("\n")).to match(/^tags\s+Delco; Forestburg; Frizzleburg; Sandston$/)
        expect(actual.first.join("\n")).to match(/^organization_name\s+Enthaze$/)
        expect(actual.first.join("\n")).to match(/^submitter_ticket_subjects\s+A Catastrophe in Gibraltar; A Drama in Georgia$/)
        expect(actual.first.join("\n"))
          .to match(/^assigned_ticket_subjects\s+A Drama in Botswana; A Drama in Cameroon; A Drama in Gabon; A Drama in Saudi Arabia$/)
      end
    end

    describe "when I select a ticket" do
      let(:input) { double(:input, model_type: :tickets, field: :assignee_id, query: '11') }

      it "returns a list of matching tickets with associated records" do
        actual = described_class.call(input)

        expect(actual.size).to eq(1)
        expect(actual.first.size).to eq(20)
        expect(actual.first.join("\n")).to match(/^subject\s+A Nuisance in Saint Lucia$/i)
        expect(actual.first.join("\n")).to match(/^organization_name\s+Qualitern$/)
        expect(actual.first.join("\n")).to match(/^assignee_name\s+Shelly Clements$/)
        expect(actual.first.join("\n")).to match(/^submitter_name\s+Francisca Rasmussen$/)
      end
    end

    describe "when I select an organization" do
      let(:input) { double(:input, model_type: :organizations, field: :_id, query: '103') }

      it "returns a list of matching organizations with associated records" do
        actual = described_class.call(input)

        expect(actual.size).to eq(1)
        expect(actual.first.size).to eq(10)
        expect(actual.first.join("\n")).to match(/^name\s+Plasmos$/i)
        expect(actual.first.join("\n")).to match(/^domain_names\s+automon.com; comvex.com; gogol.com; verbus.com$/)
        expect(actual.first.join("\n")).to match(/^tags\s+Armstrong; Lindsay; Parrish; Vaughn$/)
      end

      it "returns multiple organizations" do
        input = double(:input, model_type: :users, field: :organization_id, query: '106')
        actual = described_class.call(input)

        expect(actual.size).to eq(4)
        expect(actual.map { |a| a[4].delete(' ') })
          .to eq(%w[nameCrossBarlow nameAlvarezBlack nameSampsonCastillo nameLynnetteDunlap])
      end
    end
  end
end

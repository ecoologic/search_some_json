describe Models::User do
  describe '#decorated_record' do
    it "returns N/A when associations can't be found" do
      subject = described_class.new({ stuff: true })

      actual = subject.decorated_record({})

      expect(actual).to eq(assigned_ticket_subjects: "N/A", organization_name: "N/A", stuff: true)
    end
  end
end

# frozen_string_literal: true

describe Models::User do
  describe '#decorated_record' do
    it "returns N/A when associations can't be found" do
      subject = described_class.new({ stuff: true })

      actual = subject.decorated_record

      expect(actual).to eq(organization_name: nil,
                           stuff: true,
                           assigned_ticket_subjects: [],
                           submitter_ticket_subjects: [])
    end
  end
end

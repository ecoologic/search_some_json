describe Input do
  let(:ui) { double(:ui, select: 'stuff') }
  subject(:input) { described_class.new(ui) }

  describe '#model_type' do
    it "prompts a selection" do
      expect(input.model_type).to eq(:stuff)
    end
  end
end

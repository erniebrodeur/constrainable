require 'spec_helper'

# for every constraint we have two binding points per constraint.
# what we are constraining (single method or whole class)
# what we are constraining by (type, required, block)
# so the top level constraint class needs attributes:
# - target (method name or class / self / token for class)
# - by (what we want to restrain by (type, required, block))
# - with (any additional arguments the block needs)
describe Constrainable::Constraint do
  include_context "with harness"
  include_context "with constraint"

  subject { test_constraint }

  let(:described_class) { TestConstraint }

  it { is_expected.to have_attributes(target: a_kind_of(Symbol)) }
  it { is_expected.to have_attributes(by: a_kind_of(Symbol)) }
  it { is_expected.to have_attributes(with: anything) }

  # it { is_expected.to respond_to(:trigger) }
  it { is_expected.to respond_to(:constrained?) }
  it { is_expected.to respond_to(:exception_message) }

  describe "#initialize", keywords: { target: :a_method, by: :required, with: String } do
    metadata[:keywords].each do |key, value|
      it "is expected to set @#{key} to #{value}" do
        expect(TestConstraint.new(call_params).send(key)).to eq value
      end

      context "when any #{key} is nil" do
        before { call_params[key] = nil }

        it { expect { subject }.to raise_error ArgumentError, "#{key} is a required keyword" }
      end
    end
  end

  describe "#constrained?" do
    let(:value) { false }

    context "when the test fails" do
      let(:value) { true }

      it { expect(test_constraint.constrained?(value)).to be true }
    end

    it { expect(test_constraint.constrained?(value)).to be false }
  end

  # describe "#trigger" do
  #   it "is expected to call constrained?" do
  #     allow(test_constraint).to receive(:constrained?).and_return(true)
  #     test_constraint.trigger true
  #     expect(test_constraint).to have_received(:constrained?).with(true)
  #   end

  #   context "when constrained is false" do
  #     before do
  #       allow(test_constraint).to receive(:constrained?).and_return(false)
  #     end

  #     it "is expected to call the original method with arguments"
  #     it "is expected to return the result of the original method"
  #   end

  #   context "when constrained? is true" do
  #     it "is expected to raise an error with exception_message"
  #   end
  # end

  describe "#exception_message" do
    it "is expected to return a String"
  end
end

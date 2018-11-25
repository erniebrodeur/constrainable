require 'spec_helper'

describe Constrainable::Constraints do
  include_context "with harness"
  include_context "with constraints"

  it { expect(described_class).to be_a_kind_of Class }
  it { is_expected.to be_a_kind_of Enumerable }

  it { is_expected.to respond_to(:add).with(1).argument }
  it { is_expected.to respond_to(:each).with(0).arguments }
  it { is_expected.to respond_to(:trigger).with_unlimited_arguments }

  describe "#add" do
    before { constraints.instance_variable_set :@collection, [] }

    it "is expected to add an entry to @collection" do
      expect { constraints.add constraint }.to(change { constraints.instance_variable_get(:@collection) })
    end

    context "when the argument is not a Constraint" do
      it { expect { constraints.add 'not_a_constraint' }.to raise_error ArgumentError, 'not_a_constraint is not a type of Constrainable::Constraint' }
    end
  end

  describe "#each" do
    specify { expect { |b| constraints.each(&b) }.to yield_control.once }
  end

  describe "#trigger" do
    it "is expected to call constraints.each" do
      allow(constraints).to receive(:each).and_call_original
      constraints.trigger false
      expect(constraints).to have_received(:each)
    end

    it "is expected to call constraint.constrained? with provided args" do
      allow(constraint).to receive(:constrained?).and_call_original
      constraints.trigger false
      expect(constraint).to have_received(:constrained?).with false
    end

    it { expect(constraints.trigger(false)).to be nil }

    context "when a constraint returns true" do
      it { expect { constraints.trigger true }.to raise_error ArgumentError }
    end
  end
end

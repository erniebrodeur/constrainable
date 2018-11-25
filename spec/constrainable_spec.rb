require 'spec_helper'

describe Constrainable do
  subject { Harness.new }

  include_context "with harness"
  # let(:described_class) { Harness }

  it { is_expected.to be_a_kind_of Constrainable } # rubocop: disable RSpec/DescribedClass
  it { expect(described_class).to respond_to(:rebind_method).with(2).arguments }
  it { expect(described_class).to respond_to(:create_defined_methods).with(2).arguments }
  it { expect(described_class).to respond_to(:constrained_method_wrapper).with(2).arguments }

  describe '::rename_method' do
    it "is expected to rename a method for the instantited object"
    it "is expected to name it to _method_name_"
    it "is expected to return nil"
  end

  describe '::create_defined_method' do
    it "is expected to make a new method"
    it "is expected to call constrained_method_wrapper"
    it "is expected to bind that method to the instantiated object"
    it "is expected to bind by method_name"
    it "is expected to return nil"
  end

  describe '::constrained_method_wrapper' do
    it "is expected to call constraints.trigger with the provided arguments"
    it "is expected to yield to the wrapped method"
    it "is expected to return the response from the wrapped method"
  end
end

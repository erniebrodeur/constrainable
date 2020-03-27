require 'spec_helper'

describe Constrainable::IncludedClassMethods do
  include_context "with harness"

  subject { Harness }

  let(:described_class) { Harness }

  it { expect(described_class).to respond_to(:constrain_class) }
  it { expect(described_class).to respond_to(:constrain) }
  it { expect(described_class).to respond_to(:constrained_method_wrapper).with(2).arguments }
  it { expect(described_class).to respond_to(:create_defined_methods).with(2).arguments }
  it { expect(described_class).to respond_to(:rebind_method).with(2).arguments }

  describe '#constrain' do
  end

  describe '#constrain_class' do
  end
end

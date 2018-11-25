require 'spec_helper'

describe Constrainable::IncludedClassMethods do
  include_context "with harness"

  subject { Harness }

  let(:described_class) { Harness }

  it { expect(described_class).to respond_to(:constrain) }
  it { expect(described_class).to respond_to(:constrain_class) }

  describe '#constrain' do
  end

  describe '#constrain_class' do
  end
end

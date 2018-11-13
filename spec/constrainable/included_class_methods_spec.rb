require 'spec_helper'

describe Constrainable::IncludedClassMethods do
  subject { Harness }

  before do
    class Harness
      include Constrainable

      # constrain :method, by: { required_keywords: %i[keyword two three] }
      # constrain_class by: { signed_in: true }
    end
  end

  let(:described_class) { Harness }

  it { expect(described_class).to respond_to(:constrain) }
  it { expect(described_class).to respond_to(:constrain_class) }

  describe '#constrain' do

  end

  describe '#constrain_class' do

  end
end

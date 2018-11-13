require 'spec_helper'

describe Constrainable do
  subject { Harness.new }

  before do
    class Harness
      include Constrainable

      # constrain :method, by: { required_keywords: %i[keyword two three] }
      # constrain_class by: { signed_in: true }
    end
  end

  let(:described_class) { Harness }

  it { is_expected.to be_a_kind_of Constrainable } # rubocop: disable RSpec/DescribedClass
  it { is_expected.to respond_to(:rebind_method).with(2).arguments }
  it { is_expected.to respond_to(:create_defined_methods).with(2).arguments }
  it { is_expected.to respond_to(:constrained_method_wrapper).with(2).arguments }

  describe '::rename_method' do
    it "is expected to rename a method"
    it "is expected to return nil"
  end

  describe '::create_defined_method' do
    it "is expected to make a new method"
    it "is expected to bind that method to the instantiated object"
    it "is expected to bind by method_name"
    it "is expected to return nil"
  end

  describe '::constrained_method_wrapper' do

    it "is expected to yield to the wrapped method"
    it "is expected to return the response from the wrapped method"
  end
end

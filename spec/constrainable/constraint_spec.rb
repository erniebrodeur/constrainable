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
  subject { TestConstraint.new(target: :method, by: :required, with: String) }

  let(:described_class) { TestConstraint }

  it { is_expected.to have_attributes(target: nil) }
  it { is_expected.to have_attributes(by: nil) }
  it { is_expected.to have_attributes(with: nil) }

  it { is_expected.to respond_to(:trigger) }
  it { is_expected.to respond_to(:constrained?) }
  it { is_expected.to respond_to(:exception_message) }

  describe "#constrained?" do
    let(:value) { false }

    context "when the test fails" do
      let(:value) { true }

      it { expect(test_constraint.constrained?(value)).to be true }
    end

    it { expect(test_constraint.constrained?(value)).to be false }
  end

  describe "#trigger" do
    it "is expected to call constrained?" do
      allow(test_constraint).to receive(:constrained?).and_return(true)
      test_constraint.trigger true
      expect(test_constraint).to have_received(:constrained?).with(true)
    end

    context "when constrained is false" do
      before do
        allow(test_constraint).to receive(:constrained?).and_return(false)
      end

      it "is expected to call the original method with arguments"
      it "is expected to return the result of the original method"
    end

    context "when constrained? is true" do
      it "is expected to raise an error with exception_message"
    end
  end

  describe "#exception_message" do
    it "is expected to return a String"
  end
end

# constraint
# ### create a constraint

# # class RequiredType < Constraint
# #   attr_accessor :method_name
# #   attr_accessor :type_of
# #   attr_accessor :keywords
# #   attr_accessor :positions
# #   def in_argument(position); end
# #   def in_keyword(name); end
# #   def with(type_of); end
# # end
# # constrain(:query).by(:required_type).in_argument(1).with(String)
# # constrain :query, by: :required_type, in_argument: 1, in_keyword: :this, with: String
# c = Constraint.new :required_type do |method_name, with, type, args|

# end

# c = Constraint.new :required_keyword do |method_name, with, args|
#   # parse args for keywords
#   # compare keywords to the array in required_keywords
# end

# c.name = :required_keyword
# c.block = Proc.new {|, method_arguments| }

# ### check/call the constraint

# c.raise(method_arguments)

# # constrain :query, by: :required_keyword, with: [:user, :token]
# # constrain :figure_eight, by: required_number, with: 7..9

# # 3 parts of a constraint

# # - define - type, block to check (new)
# # - setup in class - specific method, specific arguments for check (constrain by: with:)
# # - call before method - pass in arguments on the way to the method (*args)

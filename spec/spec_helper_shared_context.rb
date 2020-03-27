RSpec.shared_context "with harness" do
  before do
    class Harness
      include Constrainable

      constrain :method, by: { required_keywords: %i[keyword two three] }
      constrain_class by: { signed_in: true }
    end
  end
end

RSpec.shared_context "with constraint" do
  let(:target) { :a_method }
  let(:by) { :required }
  let(:with) { String }
  let(:call_params) { { target: target, by: by, with: with } }
  let(:test_constraint) { TestConstraint.new call_params }

  before do
    class TestConstraint < Constrainable::Constraint
      def exception_message
        "exception message"
      end

      def constrained?(value = true)
        value
      end
    end
  end
end

RSpec.shared_context "with constraints" do
  include_context "with constraint"
  let(:constraint) { test_constraint }
  let(:collection) { [constraint] }
  let(:constraints) { Constrainable::Constraints.new collection }
end

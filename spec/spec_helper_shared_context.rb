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
  let(:test_constraint) { TestConstraint.new target: :method, by: :this, with: :that}

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

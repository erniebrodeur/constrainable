module Constrainable
  # methods that are avialable inside the class builder
  module IncludedClassMethods
    # constrain :figure_eight, by: required_number, with: 7..9
    def constrain(method, by: nil, with: nil); end

    def constrain_class(args = {}); end
  end
end

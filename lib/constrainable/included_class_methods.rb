module Constrainable
  # methods that get included into the new instance.
  module IncludedClassMethods
    def constrain_method_by(method, constraint_class, *args); end

    def constrain_by(constraint_class, *args); end
  end
end

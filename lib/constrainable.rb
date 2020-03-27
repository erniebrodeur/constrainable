require "constrainable.rb"
require "constrainable/constraint.rb"
require "constrainable/constraints.rb"
require "constrainable/constraints/required_keyword.rb"
require "constrainable/included_class_methods.rb"
require "constrainable/included_instance_methods.rb"
require "constrainable/version.rb"

# constraint system that prevents unwanted method calls
module Constrainable
  # this is the magic bit that adds Class scoped methods
  def self.included(object)
    object.extend IncludedClassMethods

    def object.method_added(method_name)
      instantiated_obj = allocate

      return if method_name[0..1] == "__" || instantiated_obj.methods.include?(:"__#{method_name}")

      rebind_method instantiated_obj, method_name
      create_defined_methods instantiated_obj, method_name
    end
  end
end

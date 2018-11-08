require 'constrainable/version'
require 'constrainable/included_class_methods'

# constraint system that prevents unwanted method calls
module Constrainable
  # this is the magic bit that adds Class scoped methods
  def self.included(object)
    object.extend IncludedClassMethods

    def object.method_added(method_name)
      instantiated_obj = allocate

      return if method_name[0..1] == "__" || instantiated_obj.methods.include?(:"__#{method_name}")

      Constrainable.rebind_method self, instantiated_obj, method_name
      Constrainable.create_defined_methods self, instantiated_obj, method_name
    end
  end

  module_function

  def rebind_method(object, instantiated_obj, method_name)
    instantiated_obj.method method_name
    original_method = instantiated_obj.method method_name
    unbound_method = original_method.unbind
    object.send :remove_method, method_name
    object.send :define_method, "__#{method_name}".to_sym, unbound_method
  end

  def create_defined_methods(object, instantiated_obj, method_name)
    define_method method_name do |*args|
      puts 'constrainment check'
      m = method "__#{method_name}".to_sym
      send(:raise, ArgumentError, "constrainment error for #{instantiated_obj.class}::#{method_name}(#{args})") if args.empty?
      m.call(*args)
    end
  end

  def constrained_method_wrapper(_method_name, *_args)
    puts "Constraint check this bitch!"
  end
end

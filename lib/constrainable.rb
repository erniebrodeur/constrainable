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

  # instance methods go here with def name;end

  # classic class methods with def self.name;end
  def self.rebind_method(instantiated_obj, method_name)
    instantiated_obj.method method_name
    original_method = instantiated_obj.method method_name
    unbound_method = original_method.unbind
    instantiated_obj.class.send :remove_method, method_name
    instantiated_obj.class.send :define_method, "__#{method_name}".to_sym, unbound_method
  end

  def self.create_defined_methods(instantiated_obj, method_name)
    define_method method_name do |*args|
      puts 'constrainment check'
      m = method "__#{method_name}".to_sym
      send(:raise, ArgumentError, "constrainment error for #{instantiated_obj.class}::#{method_name}(#{args})") if args.empty?
      m.call(*args)
    end
  end

  def self.constrained_method_wrapper(_method_name, *_args)
    puts "Constraint check this bitch!"
  end
end

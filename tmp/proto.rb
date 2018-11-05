# use event self.included?
# on that hook, add a hook to method_add
# the method_add hook moves the old method over to __original_method
# the method_add hook creates a new method with the same name
# the new method calls constrain_method :moved_method
# now when triggering that method, it calls into constrain_method
# constrained_method walks through the class constraints, and if it finds one, exits.
require 'pry'


module Constrainable
  # this is the magic bit that adds Class scoped methods
  def self.included(object)
    object.extend ClassMethods

    def object.method_added(method_name)
      instantiated_obj = allocate
      if method_name[0..1] == "__" || instantiated_obj.methods.include?(:"__#{method_name}")
        puts "Previously added #{method_name}"
      else
        puts "added #{method_name} via constrainable"
        instantiated_obj.method method_name
        original_method = instantiated_obj.method method_name
        unbound_method = original_method.unbind
        remove_method method_name
        define_method "__#{method_name}".to_sym, unbound_method

        define_method method_name do |*args|
          puts 'constrainment check'
          m = method "__#{method_name}".to_sym
          self.send(:raise, ArgumentError, "constrainment error for #{instantiated_obj.class}::#{method_name}(#{args})") if args.empty?
          m.call *args
        end
      end
    end
  end

  module ClassMethods
    def constrain_method_by(method, constraint_class, *args);end
    def constrain_by(constraint_class, *args);end
  end

  module_function
  def constrained_method_wrapper(method_name, *args)
    puts "Constraint check this bitch!"
  end
end

class Constrained
  include Constrainable

  constrain_by :global_constraint
  constrain_method_by :this, :required_keyword, :yo

  def this(yo: nil)
    puts "should only be called if #{yo} is available."
  end
end

c = Constrained.new
puts c.this(yo: 'yo')
puts c.this

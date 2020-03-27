module Constrainable
  # methods that are avialable inside the class builder
  module IncludedClassMethods
    # constrain :figure_eight, by: required_number, with: 7..9
    def constrain(_method, by: nil, with: nil)
      '...' if by == :required_keyword_argument
    end

    def constrain_class(args = {}); end

    def constrained_method_wrapper(_method_name, *_args)
      puts "Constraint check this bitch!"
    end

    def create_defined_methods(instantiated_obj, method_name)
      define_method method_name do |*args|
        m = method "__#{method_name}".to_sym
        send(:raise, ArgumentError, "constrainment error for #{instantiated_obj.class}::#{method_name}(#{args})") if args.empty?
        m.call(*args)
      end
    end

    def rebind_method(instantiated_obj, method_name)
      instantiated_obj.method method_name
      original_method = instantiated_obj.method method_name
      unbound_method = original_method.unbind
      instantiated_obj.class.send :remove_method, method_name
      instantiated_obj.class.send :define_method, "__#{method_name}".to_sym, unbound_method
    end
  end
end

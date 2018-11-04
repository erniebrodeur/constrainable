require "constrainable/version"

module Constrainable
  # def constrain(*args); end

  # generate a 'named' method as part of the dsl (to supply required_keyword below).
  # attach that method to Constrainable
  # by including Constrainable (or Constrainable::ClassMethods or whatever) you will end up with a new
  # method called required_keyword
  module_function
  def required_keyword(binding: binding, arguments: arguments)
    raise 'AbstractClass'
  end
end

# abstract
class Constraint
  def generate_named_method
  end

  def call(binding: nil, arguments: nil)
  end
end

class RequiredKeyword < Constraint
  def method_name
    :required_keyword # get this automagically (in the future)
  end

  def call(binding: nil, arguments: nil)
  # figure out how to pass the binding
  # dig and find the local bit from the binding.
  raise ArgumentError, "#{keyword} was not supplied" unless value
end

class A
  include Constrainable

  @constraints = {
    RequiredArgument => %i[keyword two three]
  }

  # later on
  constraints.each {|c, arguments| c.call(binding: binding, arguments: arguments) }

  # begin
  #   constrain :some_method, :arg1, kind_of: String, required: true
  #   constrain :some_method, :arg2, kind_of: String, required: true
  #   constrain :some_method, :two, kind_of: String, required: true
  #   constrain :some_method, :three, kind_of: String, required: true
  # end

  # by :required_keywords, :some_method, kind_of: %i[keyword two three]
  # by :user_signed_in, :some_method, user: user

  # Constrainable.by_require_keywords :some_method, %i[keyword two three]
  # Constrainable.by_kind_of :some_method, %i[keyword two three], [String, nil]

  # by_user_signed_in :some_method, user
  # by_require_keywords %i[keyword two three]
  # by_kind_of [String, nil], %i[keyword two three]
  # by_kind_of Array, %i[arg1 arg2]
  # this call will supply the binding and the method_name (since it's in scope).
  
  def some_method(arg1, arg2, keyword: nil, two: nil, three: nil)
    raise ArgumentError, 'keyword must be present' unless keyword
    raise ArgumentError, 'two must be present' unless two
    raise ArgumentError, 'three must be present' unless three
    # -> factors to this
    [keyword, two, three].each { |v| raise ArgumentError, "#{v} must be present" unless v }
    # -> factors to this
    required_keyword %i[keyword two three]

    puts arg1, arg2, keyword, two, three
  end
end

module Constrainable
  module By
    module UserSignedIn
      module_function
      def wrapper(method, *args)
        puts 'blow_up' unless args.any?

        send method, args
      end
    end
  end
end

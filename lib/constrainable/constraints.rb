module Constrainable
  class Constraints
    include Enumerable

    def initialize(collection = [])
      @collection = collection
    end

    def add(constraint)
      raise ArgumentError, "#{constraint} is not a type of Constrainable::Constraint" unless constraint.is_a? Constraint

      @collection.push constraint
    end

    def each
      @collection.each { |c| yield c }
    end

    def trigger(*args)
      each do |constraint|
        raise ArgumentError, constraint.exception_message if constraint.constrained?(*args)
      end

      nil
    end
  end
end

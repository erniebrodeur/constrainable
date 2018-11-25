module Constrainable
  class Constraint
    attr_accessor :target
    attr_accessor :by
    attr_accessor :with

    def initialize(target: nil, by: nil, with: nil)
      nil
    end

    def trigger(*args)
      # constrained?
    end

    def constrained?(*args)
      raise
    end

    def exception_message(*args)
      raise
    end

    private

    def define_type
      # if type :method
      # if type :self
    end
  end
end

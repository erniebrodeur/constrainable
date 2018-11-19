module Constrainable
  class Constraint
    attr_accessor :target
    attr_accessor :by
    attr_accessor :with

    def trigger(*args)
    end

    def constrained?(*args)
    end

    def exception_message(*args)
    end
  end
end

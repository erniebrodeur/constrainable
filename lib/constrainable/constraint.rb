module Constrainable
  class Constraint
    attr_accessor :target
    attr_accessor :by
    attr_accessor :with

    def initialize(target: nil, by: nil, with: nil)
      raise ArgumentError, 'target is a required keyword' unless target
      raise ArgumentError, 'by is a required keyword' unless by
      raise ArgumentError, 'with is a required keyword' unless with

      @target = target
      @by = by
      @with = with
    end

    def constrained?(*_args)
      raise
    end

    def exception_message(*_args)
      raise
    end
  end
end

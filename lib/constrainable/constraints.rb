module Constrainable
  class Constraints
    attr_writer :collection

    include Enumerable

    def initialize
      @collection = []
    end

    def each
      @collection.each { |c| yield c }
    end
  end
end

# use event self.included?
# on that hook, add a hook to method_add
# the method_add hook moves the old method over to __original_method
# the method_add hook creates a new method with the same name
# the new method calls constrain_method :moved_method
# now when triggering that method, it calls into constrain_method
# constrained_method walks through the class constraints, and if it finds one, exits.
require 'pry'
require 'constrainable'

class Constrained
  include Constrainable

  constrain_by :global_constraint
  # constrain_method_by :this, :required_keyword, :yo

  def this(yo: nil)
    "should only be called if #{yo} is available."
  end
end

c = Constrained.new
puts "c.this(yo: 'yo') = #{c.this(yo: 'yo')}"
puts "c.this = #{c.this}"

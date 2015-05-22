class Supervisor < Staff

  attr_reader :role

 def initialize(name,role)
   super(name)
   @role = role
 end
end


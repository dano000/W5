class Staff
  attr_reader :all_staff,:name, :id
  @@all_staff = []

  def initialize(name)
    @name = name
    @id = @@all_staff.length + 1
    @@all_staff.push(self)
  end

  def self.all_staff
    @@all_staff
  end
end
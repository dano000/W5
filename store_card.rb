class StoreCard < Card

  attr_reader :balance

  def initialize(b)
    super
    @balance = b

  end


  def add_balance(value)
    @balance += value
  end

end
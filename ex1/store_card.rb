class StoreCard < Card

  attr_reader :balance, :discount

  def initialize(b = 0)
    super
    @balance = b
    @discount = 10 #percentage of discount
  end

  def subtract_balance(value)
    if value < @balance
      @balance -= value
      return true
    else
      return false
    end

end
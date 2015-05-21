class CreditCard < Card

  attr_reader :limit

  def initialize(l)
    super
    @initial_limit = l
    @limit = l
  end

  def subtract_limit(value)
    if value < @limit
      @limit -= value
      return true
    end
  else
    puts 'value exceeds limit'
    return false
  end


  def reset_limit
    @limit = @initial_limit
  end

end
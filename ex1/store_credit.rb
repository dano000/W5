class StoreCredit < PaymentGateway

  def valid(card)
    if card.class == StoreCard.class
      true
    else
      false
  end

  def self.add_balance(card,value)
    if valid(card)
      card.balance += value
    else
      puts "Please use a valid store card. Err add bal"
    end
  end

  def self.charge(card,value)

    if valid(card)
      if card.subtract_balance(value)
      return true
      else
        return false
    else
      "Please use a valid store card. Err sub bal"
      return false
    end

  end

  end



class PaymentGateway

  def self.validate(card)

    if card.expiration_date > Date.today

    if card.class == StoreCard.class
      return true
    elsif card.class == CreditCard.class
      return true
    else
      puts 'Card is not Store Card or Credit Card'
      return false
    end
    else
      puts 'Card has expired'
    end
  end

  def self.charge(card,amount)

    if card.class == StoreCard.class
      if StoreCredit.charge(card,amount)
        puts 'Store Sale Approved'
        return true
      else
        puts 'Store Sale Declined'
        return false
      end

    end

    if card.class == CreditCard.class
      if CreditAgency.charge(card,amount)
        puts 'Credit Sale Approved'
        return true
      else
        puts 'Credit Sale Declined'
        return false
      end

    end
  end

end
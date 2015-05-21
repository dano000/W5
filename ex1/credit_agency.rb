class CreditAgency < PaymentGateway

  def valid(card)
    if card.class == CreditCard.class
      true
    else
      false
    end

  def self.charge(card,value)

    if valid(card)
        if card.subtract_limit(value)
          return true
        else
          return false
        end
      else
        puts 'value exceeds limit'
      end


  end

end
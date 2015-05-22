class Customer

  attr_reader :name,:date_of_birth,:contact_details,:discount_eligible

  def initialize(n,dob,c,d)

    @name = n
    @date_of_birth = dob
    @contact_details = c
    @discount_eligible = d
    @cards = []
  end

  def add_card(card)
    if card.class == Card.class
      @cards.push(card)
    end
  end

end


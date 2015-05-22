class Card
  attr_reader :owner,:issuer,:card_number,:expiration_date,:validation
  def initialize(o,i,c,e,v)
    @owner = o
    @issuer = i
    @card_number = c
    @expiration_date = e
    @validation = v
  end
end


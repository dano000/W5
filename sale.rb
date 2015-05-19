require "item"
class Sale

  attr_reader :id,:items_list,:disc,:time,:total,:total_discount,:amount_payable,:card

  def initialize(card_type)
    @id = rand(10000)
    @items_list = []
    @disc = nil
    @time = Time.now
    @total = calc_total
    @total_discount = apply_discount
    @amount_payable = calc_payable
    @card = card_type
  end


end

def add_item(item)
  if item.class == Item.class
    :items_list.push(item)
    calc_payable
    true
  else
    false
  end
end

def calc_total
  total = 0
  :items_list.each do |i|
    total += i.price
  end
  @total = total
end

def apply_discount
  total_discount = 0
  :items_list.each do |i|
    total_discount += i.discount
  end
  @total_discount = total_discount
end

def calc_payable
  calc_total
  apply_discount
  return (@total - @total_discount)
end

def
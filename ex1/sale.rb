require "item"
class Sale

  attr_reader :id,:items_list,:disc,:time,:total,:total_discount,:amount_payable,:card

  @@sales = []

  def initialize
    @id = @@sales.length + 1
    @items_list = []
    @disc = nil
    @time = Time.now
    @total = calc_total
    @total_discount = apply_discount
    @amount_payable = calc_payable
    @card = nil
    @staff = nil
    @@sales.push(self)
  end

  def sales
    @@sales
  end

  def assign_staff(staff)
    @staff = staff
  end

  def add_card(card)
    @card = card
  end

def add_item(item)
  if item.class == Item.class
    @items_list.push(item)
    calc_payable
    true
  else
    false
  end
end

def calc_total
  total = 0
  @items_list.each do |i|
    total += i.price
  end
  @total = total
end

def apply_discount
  total_discount = 0
  @items_list.each do |i|
    total_discount += i.discount
  end
  @total_discount = total_discount
end

def calc_payable
  calc_total
  apply_discount

  if @card.class == StoreCard.class
    ((100.0 - @card.discount)/100.0) *(@total - @total_discount)
  else
    (@total - @total_discount)
  end

end
end


class SaleServer

  def initialize
    @sale_hash = Hash.new
  end


  def make(staff,card,item)
    o = Sale.new
    o.assign_staff(staff)
    o.add_card(card)
    o.add_item(item)
    add_sale(o)
    o
  end

  def add_sale(sale)
    if sale.class == Sale.class
      @sale_hash[sale] = sale.staff
    else
      puts 'Error: please enter correct Sale'
    end
  end

  def query_staff(staff)
    @sale_hash.key(staff)
  end

end


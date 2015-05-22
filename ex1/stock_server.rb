class StockServer

  def initialize
    @item_hash = Hash.new
    @barcode_hash = Hash.new
    @stockcode_hash = Hash.new
  end

#makes new Item and adds to server
  def add_new_item(n,d,p,b,s, disc=[])
    o = Item.new(n,d,p,b,s, disc)
    add_stock(o)
    o
  end

  #adds stock to server
  #if item does not exist
  #adds new key to hash

  def add_stock(item)
    if item.class == Item.class
      if @item_hash[item]
        @item_hash[item] += 1
      else
        @item_hash[item] = 1
        @barcode_hash[item] = item.barcode
        @stockcode_hash[item] = item.stockcode
      end
    else
      puts 'Error: please enter correct Item'
    end
  end

  #returns stock amount for an Item
  def query(item)
    @item_hash[item] ? @item_hash[item] :  nil
  end

  #subtracts current stock available

  def subtract_stock(item)
    if item.class == Item.class
      if @item_hash[item] > 0
        @item_hash[item] -= 1
        true
      else
        puts 'Error: currently no stock'
        false
      end
    else
      puts 'Error: please enter correct Item'
    end
  end

  #returns Item from a given barcode
    def query_by_barcode(barcode)
    @barcode_hash.key(barcode)
  end

  #returns Item from a given stockcode
  def query_by_stockcode(stockcode)
    @stockcode_hash.key(stockcode)
  end

end


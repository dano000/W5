class Item
  attr_reader :name,:description,:price,:barcode,:stockcode

  def initialize(n,d,p,b,s, disc=[])
    @name = n
    @description = d
    @price = p
    @barcode = b
    @stockcode = s
    @discount = disc
  end

end


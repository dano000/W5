class SecuritySystem

  def initialize(stock_server,item_server)
    if stock_server.class == StockServer.class
      @stock_server = stock_server
    else
      puts 'Error: Invalid Stock server'
    end

  end

  def self.release(item_barcode)
    item = @stock_server.query_by_barcode(item_barcode)
    if @stock_server.subtract_stock(item)
      puts 'Item release'
      true
    else
      puts 'Item not released'
      false
    end
  end

end


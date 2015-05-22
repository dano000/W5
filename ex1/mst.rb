class MST

  @@all_mst = []

  def initialize(discount_server,sale_server,stock_server)

    @id = @@all_mst.length + 1
    @@all_mst.push(self)

    @authenticated = false
    @supervisor_auth = false
    @current_sale = nil
    @current_card = nil

    @disc_server = discount_server
    @sale_server = sale_server
    @stock_server = stock_server


  end

  def authenticate(staff)
    if
      staff.class == Staff.class
      @authenticated = true
    end
    if
      staff.class == Supervisor.class
      @supervisor_auth = True
    end
  end

  def scan_barcode(item)

  end

  def initialise_sale(item)
    @current_sale = Sale.new
    @current_sale.add_item(item)
  end

  def add_to_sale(item)
    if @current_sale != nil
      @current_sale.add_item(item)
    else
      puts 'Error: please initialise sale'
    end
  end

  def initialise_card(card)
    if PaymentGateway.validate(card)
      puts 'Card Valid'
      @current_card = card
    else
      puts 'Card Invalid'
    end

  end

  def charge_card
    (PaymentGateway.charge(@current_card, @current_sale.amount_payable)) ? true : false
  end

  def release_item(item)
    if charge_card
      @current_sale.items_list.each do |i|
        SecuritySystem.release(i.barcode)
      end
    end

  end

  def query_staff(staff)
    if @supervisor_auth == True
    @sale_server.query_staff(staff)
    else
      put 'Access Denied: Must Login as Supervisor'
    end
  end

  def query_discount_item(item)
    if @supervisor_auth == True
      @disc_server.query_disc_item(item)
    else
      put 'Access Denied: Must Login as Supervisor'
    end
  end

  def self.all_mst
    @@all_mst
  end

end


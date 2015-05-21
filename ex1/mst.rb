class MST

  @@all_mst = []

  def initialize

    @id = @@all_mst.length + 1
    @@all_mst.push(self)

    @authenticated = false
    @supervisor_auth = false
    @current_sale = nil
    @current_card = nil

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
    if(PaymentGateway.charge(@current_card,@current_sale.amount_payable))
      return true
    else
      return false
    end
  end

  def release_item(item)
    if charge_card == true
      @current_sale.
    end

  end

  def query_staff(staff)

  end

  def query_discount_item(item)

  end



  def self.all_mst
    @@all_mst
  end

end
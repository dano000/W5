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

class CreditAgency < PaymentGateway

  def valid(card)
    if card.class == CreditCard.class
      true
    else
      false
    end

  def self.charge(card,value)

    if valid(card)
        if card.subtract_limit(value)
          return true
        else
          return false
        end
      else
        puts 'value exceeds limit'
      end


  end

  end

end



class CreditCard < Card

  attr_reader :limit

  def initialize(o,i,c,e,v,l)
    super(o,i,c,e,v)
    @initial_limit = l
    @limit = l
  end

  def subtract_limit(value)
    if value < @limit
      @limit -= value
      return true
    end
  else
    puts 'value exceeds limit'
    return false
  end


  def reset_limit
    @limit = @initial_limit
  end

end

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

class Discount
  def initialize(amount,start_date,end_date)
    @amount = amount
    @start_date = start_date
    @end_date = end_date
  end
end

class DiscountServer

  def initialize
      @disc_hash_date = Hash.new
      @disc_hash_item = Hash.new
  end

    def make(amount,start_date,end_date,item)
      o = Discount.new(amount, start_date,end_date)
      add_disc_dates(o)
      add_disc_item(o,item)
      o
    end

    def add_disc_dates(disc)
      if disc.class == Discount.class
        @disc_hash_date[disc] = [disc.start_date,disc.end_date]
      else
        puts 'Error: please enter correct Discount'
      end
    end

  def add_disc_item(disc,item)
    if disc.class == Discount.class and item.class == Item.class
      @disc_hash_item[disc] = item
    else
      puts 'Error: please enter correct Discount or Item'
    end
  end

    def query_disc_date(disc)
      @disc_hash_date[disc] ?  @disc_hash_date[disc] :  nil
    end

    def query_disc_item(item)
      @disc_hash_item.key(item)
    end

    def delete_disc(disc)
      @disc_hash_date.delete(disc)
    end

end

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
      @supervisor_auth = true
    end
  end

  def scan_barcode(item)
    @stock_server.query_by_barcode(item.barcode)
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

  def release_items
    if charge_card
      @current_sale.items_list.each do |i|
        SecuritySystem.release(i.barcode)
      end
    end

  end

  def query_staff(staff)
    if @supervisor_auth
    @sale_server.query_staff(staff)
    else
      put 'Access Denied: Must Login as Supervisor'
    end
  end

  def query_discount_item(item)
    if @supervisor_auth
      @disc_server.query_disc_item(item)
    else
      put 'Access Denied: Must Login as Supervisor'
    end
  end

  def self.all_mst
    @@all_mst
  end

end


class PaymentGateway

  def self.validate(card)

    if card.expiration_date > Date.today

    if card.class == StoreCard.class
      return true
    elsif card.class == CreditCard.class
      return true
    else
      puts 'Card is not Store Card or Credit Card'
      return false
    end
    else
      puts 'Card has expired'
    end
  end

  def self.charge(card,amount)

    if card.class == StoreCard.class
      if StoreCredit.charge(card,amount)
        puts 'Store Sale Approved'
        return true
      else
        puts 'Store Sale Declined'
        return false
      end

    end

    if card.class == CreditCard.class
      if CreditAgency.charge(card,amount)
        puts 'Credit Sale Approved'
        return true
      else
        puts 'Credit Sale Declined'
        return false
      end

    end
  end

end

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

class SecuritySystem

  def initialize(stock_server)
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

class Staff
  attr_reader :all_staff,:name, :id
  @@all_staff = []

  def initialize(name)
    @name = name
    @id = @@all_staff.length + 1
    @@all_staff.push(self)
  end

  def self.all_staff
    @@all_staff
  end
end

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

class StoreCard < Card

  attr_reader :balance, :discount

  def initialize(o,i,c,e,v,b = 0)
    super(o,i,c,e,v)
    @balance = b
    @discount = 10 #percentage of discount
  end

  def subtract_balance(value)
    if value < @balance
      @balance -= value
      true
    else
      false
    end
  end
end

class StoreCredit < PaymentGateway

  def valid(card)
    if card.class == StoreCard.class
      true
    else
      false
    end
  end

  def self.add_balance(card,value)
    if valid(card)
      card.balance += value
    else
      puts 'Please use a valid store card. Err add bal'
    end
  end

  def self.charge(card,value)

    if valid(card)
      if card.subtract_balance(value)
      return true
      else
        return false
      end
    else
      'Please use a valid store card. Err sub bal'
      return false
    end

  end
  end

class Supervisor < Staff

  attr_reader :role

 def initialize(name,role)
   super(name)
   @role = role
 end
end

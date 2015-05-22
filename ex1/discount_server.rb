class DiscountServer

  def initialize
      @disc_hash_date = Hash.new
      @disc_hash_item = Hash.new
  end

    def make(amount,startDate,endDate,item)
      o = Discount.new(amount, startDate,endDate)
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
      @disc_hash_date[disc] ? return @disc_hash_date[disc] : return nil
    end

    def query_disc_item(item)
      @disc_hash_item.key(item)
    end

    def delete_disc(disc)
      @disc_hash_date.delete(disc)
    end

end


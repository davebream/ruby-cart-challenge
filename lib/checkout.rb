require_relative './stock'

class Checkout
  def initialize(promotional_rules = [])
    @promotional_rules = promotional_rules
    @items             = []
  end

  def scan(item)
    @items << item
  end

  def total
    @items.map(&:price_cents).inject(0, :+)
  end
end

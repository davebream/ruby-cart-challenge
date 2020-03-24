# frozen_string_literal: true

class Cart
  attr_accessor :items, :discount_cents

  def initialize
    @items          = []
    @discount_cents = 0
  end

  def add(item)
    @items << item
  end

  def item_quantity(code)
    items_by_product_code(code).size
  end

  def items_by_product_code(code)
    @items.select { |item| item.code == code }
  end

  def apply_discount(amount_in_cents)
    @discount_cents += amount_in_cents
  end

  def items_total_cents
    @items.map(&:price_cents).inject(0, :+)
  end

  def total_cents
    items_total_cents - discount_cents
  end

  def formatted_total
    format('£%.2f', (BigDecimal(total_cents.round) / 100))
  end
end

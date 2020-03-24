# frozen_string_literal: true

class Stock
  Product = Struct.new(:code, :name, :price_cents)

  def initialize
    @items = {
      '001' => Product.new('001', 'Red Scarf', 925),
      '002' => Product.new('002', 'Silver cufflinks', 4500),
      '003' => Product.new('003', 'Silk Dress', 1995)
    }
  end

  def all
    @items.values
  end

  def find(code)
    @items[code]
  end
end

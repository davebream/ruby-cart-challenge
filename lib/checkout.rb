# frozen_string_literal: true

require_relative './cart'
require_relative './stock'
require_relative './promotional_rules/promotional_rules'

class Checkout
  def initialize(promotional_rules)
    @promotional_rules = PromotionalRules::Validate.new.call(promotional_rules)
    @cart              = Cart.new
  end

  def scan(item)
    @cart.add(item)
  end

  def total
    apply_promotional_rules
    @cart.formatted_total
  end

  private

  def apply_promotional_rules
    PromotionalRules::ApplyOnCart.new(@cart).call(@promotional_rules)
  end
end

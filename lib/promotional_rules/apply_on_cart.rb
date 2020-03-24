# frozen_string_literal: true

require_relative './min_cart_total_fraction_discount_strategy'
require_relative './min_product_quantity_price_strategy'

module PromotionalRules
  class ApplyOnCart
    RULE_STRATEGIES = {
      min_cart_total_fraction_discount: MinCartTotalFractionDiscountStrategy,
      min_product_quantity_price: MinProductQuantityPriceStrategy
    }.freeze

    def initialize(cart)
      @cart = cart
    end

    def call(promotional_rules)
      promotional_rules.each { |rule| apply_rule_on_cart(rule) }
    end

    private

    def apply_rule_on_cart(rule)
      strategy = RULE_STRATEGIES[rule.rule_type]
      return if strategy.nil?

      rule_discount = strategy.new(@cart).call(rule)
      @cart.add_discount(rule_discount)
    end
  end
end

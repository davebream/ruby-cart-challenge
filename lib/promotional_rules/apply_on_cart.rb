# frozen_string_literal: true

require_relative './min_cart_total_discount_strategy'
require_relative './product_quantity_discount_strategy'

module PromotionalRules
  class ApplyOnCart
    RULE_STRATEGIES = {
      min_total_discount: MinCartTotalDiscountStrategy,
      quantity_discount: ProductQuantityDiscountStrategy
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
      @cart.apply_discount(rule_discount)
    end
  end
end

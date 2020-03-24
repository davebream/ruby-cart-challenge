# frozen_string_literal: true

module PromotionalRules
  class MinProductQuantityPriceStrategy
    def initialize(cart)
      @cart        = cart
      @value_cents = 0
      @calculator  = Calculator.new(@cart)
    end

    def call(rule)
      @rule = rule

      if highest_discount_option
        @value_cents = @calculator.call(@rule.product_code, highest_discount_option)
      end

      @value_cents
    end

    private

    def highest_discount_option
      min_quantity_reached_options.max_by { |option| option[:quantity] }
    end

    def min_quantity_reached_options
      @rule.options.select { |option| @cart.item_quantity(@rule.product_code) >= option[:quantity] }
    end

    class Calculator
      def initialize(cart)
        @cart = cart
      end

      def call(product_code, option)
        items_eligible_for_discount = @cart.items_by_product_code(product_code)
        items_eligible_for_discount.map { |item| item.price_cents - option[:price_cents] }.inject(0, :+)
      end
    end
  end
end

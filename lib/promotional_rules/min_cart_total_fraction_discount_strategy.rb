# frozen_string_literal: true

module PromotionalRules
  class MinCartTotalFractionDiscountStrategy
    def initialize(cart)
      @cart        = cart
      @value_cents = 0
      @calculator  = Calculator.new(@cart)
    end

    def call(rule)
      @rule = rule

      @value_cents = @calculator.call(highest_discount_option) if highest_discount_option
      @value_cents
    end

    private

    def highest_discount_option
      min_total_reached_options.max_by { |option| option[:min_total_cents] }
    end

    def min_total_reached_options
      @rule.options.select { |option| @cart.total_cents >= option[:min_total_cents] }
    end

    class Calculator
      def initialize(cart)
        @cart = cart
      end

      def call(option)
        (@cart.total_cents * option[:fraction]).to_i
      end
    end
  end
end

# frozen_string_literal: true

require 'dry-struct'
require_relative '../types'

module PromotionalRules
  class Rule < Dry::Struct
    attribute :options,   Types::Strict::Array.of(Types::Strict::Hash)
  end

  class CartRule < Rule
    attribute :rule_type, Types::Strict::Symbol.enum(:min_cart_total_fraction_discount)
  end

  class ProductRule < Rule
    attribute :product_code, Types::Strict::String
    attribute :rule_type, Types::Strict::Symbol.enum(:min_product_quantity_price)
  end
end

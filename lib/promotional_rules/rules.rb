# frozen_string_literal: true

require 'dry-struct'

module Types
  include Dry.Types()
end

module PromotionalRules
  class Rule < Dry::Struct
    attribute :options, Types::Strict::Array.of(Types::Strict::Hash)
  end

  class CartRule < Rule
    attribute :rule_type, Types::Strict::Symbol.enum(:min_total_discount)
  end

  class ProductRule < Rule
    attribute :product_code, Types::Strict::String
    attribute :rule_type, Types::Strict::Symbol.enum(:quantity_discount)
  end
end

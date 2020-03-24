# frozen_string_literal: true

module PromotionalRules
  Invalid = Class.new(StandardError)

  class Validate
    def call(rules)
      @rules = rules

      validate_rule_types_valid!
      validate_one_rule_per_product_and_rule_type!

      @rules
    end

    private

    def validate_rule_types_valid!
      unless @rules.all? { |rule| rule.is_a?(Rule) }
        raise Invalid, 'Each rule must be an instance of PromotionalRules::Rule'
      end

    end

    def validate_one_rule_per_product_and_rule_type!
      unless rules_grouped_by_product_and_type.values.map(&:size).all? { |occurences| occurences <= 1 }
        raise Invalid, 'Only one rule per product & type allowed'
      end
    end

    def rules_grouped_by_product_and_type
      product_rules.group_by { |rule| [rule.product_code, rule.rule_type] }
    end

    def product_rules
      @rules.select { |rule| rule.is_a?(ProductRule) }
    end
  end
end

# Ruby Cart Challenge

## Products in `Stock`

| Product code | Name             | Price  |
| ------------ | ---------------- | ------ |
| 001          | Red Scarf        | £9.25  |
| 002          | Silver cufflinks | £45.00 |
| 003          | Silk Dress       | £19.95 |

### Finding product in `Stock`

```ruby
stock = Stock.new
stock.find('001')
```

## Using `PromotionalRules`

The rules are applied in the order in which they are passed into `Checkout.new`.

There are 2 types of promotional rules: `PromotionalRules::CartRule` and `PromotionalRules::ProductRule`

### `PromotionalRules::CartRule`

**required:**

- `rule_type [Symbol]`
- `options [Array<Hash>]`

**rule types:**

| `rule_type`           | `option`                                                 |
| --------------------- | -------------------------------------------------------- |
| `:min_total_discount` | `{ min_total_cents: [Integer], fraction: [BigDecimal] }` |

### `PromotionalRules::ProductRule`

**required:**

- `product_code [String]`
- `rule_type [Symbol]`
- `options [Array<Hash>]`

**rule types:**

| `rule_type`          | `option`                                              |
| -------------------- | ----------------------------------------------------- |
| `:quantity_discount` | `{ min_quantity: [Integer], price_cents: [Integer] }` |

## Example

```ruby
  promotional_rules = [
    PromotionalRules::ProductRule.new(
      product_code: '001',
      rule_type: :quantity_discount,
      options: [{ min_quantity: 2, price_cents: 850 }]
    ),
    PromotionalRules::CartRule.new(
      rule_type: :min_total_discount,
      options: [{ min_total_cents: 6000, fraction: BigDecimal('0.1') }]
    )
  ]

  stock = Stock.new

  co = Checkout.new(promotional_rules)
  co.scan(stock.find('001'))
  co.scan(stock.find('002'))
  price = co.total
```

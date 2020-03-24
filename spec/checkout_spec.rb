# frozen_string_literal: true

require 'checkout'
require 'bigdecimal'

describe Checkout do
  describe '.total' do
    let(:promotional_rules) { [] }

    let(:checkout) { described_class.new(promotional_rules) }
    let(:stock) { Stock.new }

    context 'when no rules applicable' do
      before do
        checkout.scan(stock.find('001'))
        checkout.scan(stock.find('002'))
      end

      it 'returns total of scanned products' do
        expect(checkout.total).to eq('£54.25')
      end
    end

    context 'when min_cart_total_fraction_discount rule applied' do
      before do
        checkout.scan(stock.find('001'))
        checkout.scan(stock.find('002'))
        checkout.scan(stock.find('003'))
      end

      it 'applies discount & returns calculated total' do
        expect(checkout.total).to eq('£66.78')
      end
    end

    context 'when min_product_quantity_price rule applicable' do
      before do
        checkout.scan(stock.find('001'))
        checkout.scan(stock.find('003'))
        checkout.scan(stock.find('001'))
      end

      it 'applies the discount & returns calculated total' do
        expect(checkout.total).to eq('£36.95')
      end
    end

    context 'when both min_product_quantity_price & min_cart_total_fraction_discount applicable' do
      before do
        checkout.scan(stock.find('001'))
        checkout.scan(stock.find('002'))
        checkout.scan(stock.find('001'))
        checkout.scan(stock.find('003'))
      end

      it 'applies both discounts and returns calculated total' do
        expect(checkout.total).to eq('£73.76')
      end
    end
  end
end

require 'spec_helper'

module Quantity
  describe Unit do
    it 'creates Unit' do
      expect(Unit.new 'meter').to be
    end

    it 'understands equality' do
      expect(Unit.new 'meter').to eq Unit.new 'meter'
      expect(Unit.new 'meter').not_to eq Unit.new 'kilogram'
    end

    describe ".base" do
      it 'creates base unit' do
        expect(Unit.base 'meter').to eq Unit.new 'meter'
      end
    end

    describe '.register' do
      let(:meter) { Unit.base 'meter' }

      it 'creates related unit' do
        expect(Unit.register 'centimeter', meter, 0.01).to eq Unit.new 'centimeter'
      end
    end
  end

  describe Quantity do
    it 'creates Quantity' do
      expect(Quantity.new 78, Unit.new('MB')).to be
    end

    it 'understands equality' do
      expect(Quantity.new 78, Unit.new('MB')).to eq Quantity.new 78, Unit.new('MB')
      expect(Quantity.new 78, Unit.new('MB')).not_to eq Quantity.new 13, Unit.new('MB')
      expect(Quantity.new 78, Unit.new('MB')).not_to eq Quantity.new 78, Unit.new('GB')
      expect(Quantity.new 78, Unit.new('MB')).not_to eq Quantity.new 13, Unit.new('GB')
    end

    it 'understands unit conversions' do
      meter = Unit.base('meter')
      centimeter = Unit.register('centimeter', meter, 0.01)

      expect(Quantity.new 1, meter).to eq Quantity.new 100, centimeter
    end
  end
end

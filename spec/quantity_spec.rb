require 'spec_helper'

module Quantity
  describe Unit do
    let(:meter) { Unit.register 'meter' }
    let(:centimeter) { Unit.register 'centimeter', meter, 0.01 }

    describe '.register' do

      it 'registers Unit' do
        expect(meter).to be
      end


      it 'registers related unit' do
        expect(centimeter).to be
      end
    end

    describe '#convert_to_base' do
      it 'converts quantity to base unit' do
        expect(centimeter.convert_to_base 100).to eq Quantity.new 1, meter
      end
    end

    it 'throws an error if we use new' do
      expect {Unit.new 'meter', meter, 1}.to raise_error NoMethodError
    end

    it 'understands equality' do
      expect(Unit.register 'meter').to eq Unit.register 'meter'
      expect(Unit.register 'meter').not_to eq Unit.register 'kilogram'
    end

    it 'is not equal to non-Unit' do
      expect(meter).not_to eq nil
      expect(meter).not_to eq Object.new
      expect(meter).not_to eq 78
      expect(meter).not_to eq Quantity.new 1, meter
    end

    describe '#to_s' do
      it 'returns string representation' do
        expect(meter.to_s).to eq 'meter'
      end
    end

    describe '#convert_from_base' do
      it do
        expect(centimeter.convert_from_base 1.5, meter).to eq Quantity.new 150, centimeter
      end

      it do
        expect { centimeter.convert_from_base 1.5, Unit.register('kilogram')}.to raise_error ArgumentError
        expect { centimeter.convert_from_base 1.5, Unit.register('gram')}.to raise_error ArgumentError
      end
    end
  end

  describe Quantity do
    let(:meter) { Unit.register('meter') }
    let(:centimeter) {Unit.register('centimeter', meter, 0.01) }

    it 'creates Quantity' do
      expect(Quantity.new 78, Unit.register('MB')).to be
    end

    it 'understands equality' do
      expect(Quantity.new 78, Unit.register('MB')).to eq Quantity.new 78, Unit.register('MB')
      expect(Quantity.new 78, Unit.register('MB')).not_to eq Quantity.new 13, Unit.register('MB')
      expect(Quantity.new 78, Unit.register('MB')).not_to eq Quantity.new 78, Unit.register('GB')
      expect(Quantity.new 78, Unit.register('MB')).not_to eq Quantity.new 13, Unit.register('GB')
    end

    it 'understands unit conversions' do

      expect(Quantity.new 1, meter).to eq Quantity.new 100, centimeter
    end

    it 'is not equal to non-Quantity' do
      expect(Quantity.new 1, meter).not_to eq nil
      expect(Quantity.new 1, meter).not_to eq 78
      expect(Quantity.new 1, meter).not_to eq meter
    end

    describe '#to_s' do
      it 'returns string representation' do
        expect(Quantity.new(1, meter).to_s).to eq '1 meter'
      end
    end

    describe '#convert_to' do
      it do
        expect(Quantity.new(1.5, meter).convert_to(centimeter).to_s).to eq '150.0 centimeter'
      end

      it 'does not convert to non-convertable' do
        expect { Quantity.new(1.5, meter).convert_to Unit.register 'kilogram' }.to raise_error ArgumentError
      end
    end

    describe '#+' do
      context 'with equal units' do
        it do
          expect(Quantity.new(1, meter) + Quantity.new(78, meter)).to eq Quantity.new 79, meter
        end
      end
      context 'with convertable units' do
        it do
          expect(Quantity.new(1, meter) + Quantity.new(78, centimeter)).to eq Quantity.new 178, centimeter
        end
      end
      context 'with non-convertable units' do
        it do
          expect { Quantity.new(1, meter) + Quantity.new(78, Unit.register('kilogram')) }.to raise_error ArgumentError
        end
      end

      it 'raises an error for non-Quantity' do
        expect { Quantity.new(1, meter) + nil }.to raise_error ArgumentError
        expect { Quantity.new(1, meter) + Object.new }.to raise_error ArgumentError
        expect { Quantity.new(1, meter) + 75 }.to raise_error ArgumentError
      end
    end


    describe '#-' do
      context 'with equal units' do
        it do
          expect(Quantity.new(18, meter) - Quantity.new(5, meter)).to eq Quantity.new 13, meter
        end
      end
      context 'with convertable units' do
        it do
          expect(Quantity.new(1, meter) - Quantity.new(78, centimeter)).to eq Quantity.new 22, centimeter
        end
      end
      context 'with non-convertable units' do
        it do
          expect { Quantity.new(1, meter) - Quantity.new(78, Unit.register('kilogram')) }.to raise_error ArgumentError
        end
      end

      it 'raises an error for non-Quantity' do
        expect { Quantity.new(1, meter) - nil }.to raise_error ArgumentError
        expect { Quantity.new(1, meter) - Object.new }.to raise_error ArgumentError
        expect { Quantity.new(1, meter) - 75 }.to raise_error ArgumentError
      end
    end
  end
end

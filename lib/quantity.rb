require "quantity/version"

module Quantity
  class Unit
    def initialize title, base, ratio
      @title = title
      @base = base || self
      @ratio = ratio
    end

    def == other
      return false unless other.is_a? Unit
      other.title == title
    end

    def self.register title, base=nil, ratio=1
      new title, base, ratio
    end

    def convert_to_base amount
      Quantity.new amount*ratio, base
    end

    def convert_from_base amount, other
      raise ArgumentError.new unless other.base == base
      Quantity.new amount/ratio, self
    end

    def to_s
      title
    end

    protected

    attr_reader :title, :base

    private

    private_class_method :new

    attr_reader :ratio
  end


  class Quantity
    def initialize amount, unit
      @amount = amount
      @unit = unit
    end

    PRECESION = 1e-9

    def == other
      return false unless other.is_a? Quantity
      to_base.unit == other.to_base.unit && (to_base.amount - other.to_base.amount).abs < PRECESION
    end

    def to_s
      "#{amount} #{unit}"
    end

    def convert_to other_unit
      other_unit.convert_from_base to_base.amount, unit
    end

    def + other
      inc +convert_to_my_unit(other)
    end

    def - other
      inc -convert_to_my_unit(other)
    end

    protected

    def to_base
      @base ||= unit.convert_to_base(amount)
    end

    attr_reader :amount, :unit

    private

    def convert_to_my_unit other
      assert_quantity! other
      other.convert_to(unit).amount
    end

    def inc amount_difference
      Quantity.new amount + amount_difference, unit
    end

    def assert_quantity! other
      raise ArgumentError.new 'not a quantity' unless other.is_a? Quantity
    end
  end
end

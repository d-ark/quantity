require "quantity/version"

module Quantity
  class Unit
    def initialize title
      @title = title
    end

    def == other
      other.title == @title
    end

    def self.base title
      new title
    end

    def self.register title, base, quantity
      new title
    end

    protected

    attr_reader :title
  end



  class Quantity
    def initialize value, unit
      @value = value
      @unit = unit
    end

    def == other
      value == other.value && unit == other.unit
    end

    protected

    attr_reader :value, :unit
  end
end

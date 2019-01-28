require "json"
require "math"

module BattleSnake
  class Point
    JSON.mapping( x: Int32, y: Int32 )

    def initialize(@x, @y)
    end

    def ==(other : Point)
      self.x == other.x && self.y == other.y
    end

    def +(other : Point)
      Point.new(self.x + other.x, self.y + other.y)
    end

    def -(other : Point)
      Point.new(self.x - other.x, self.y - other.y)
    end

    def distance_to(other : Point)
      (self - other).magnitude
    end

    def direction_of(other : Point)
      list = [] of String
      list << "right" if self.x < other.x
      list << "left" if self.x > other.x
      list << "down" if self.y < other.y
      list << "up" if self.y > other.y
      list
    end

    def magnitude
      (self.x + self.y).abs
    end

    def to_s(io : IO)
      io << "P(%d, %d)" % [self.x, self.y]
    end
  end
end

require "json"
require "math"

module BattleSnake
  class Point
    JSON.mapping( x: Int64, y: Int64 )

    def initialize(@x, @y)
    end

    def ==(other : Point)
      self.x == other.x && self.y == other.y
    end

    def -(other : Point)
      Point.new(self.x - other.x, self.y - other.y)
    end

    def distance_to(other : Point)
      (self - other).magnitude
    end

    def magnitude
      (self.x + self.y).abs
    end
  end
end

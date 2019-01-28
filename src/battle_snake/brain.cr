require "json"
require "./math"

module BattleSnake
  DIRECTIONS = {
    up: Point.new(0, -1),
    right: Point.new(1, 0),
    down: Point.new(0, 1),
    left: Point.new(-1, 0)
  }

  class Game
    JSON.mapping( id: String )
  end

  class Snake
    JSON.mapping(
      id: String,
      name: String,
      health: Int64,
      body: { type: Array(Point) }
    )

    def head
      body.first
    end

    def tail
      body.last
    end
  end

  class Board
    JSON.mapping(
      height: Int64,
      width: Int64,
      food: { type: Array(Point) },
      snakes: { type: Array(Snake) }
    )

    def initialize(@height, @width, @food, @snakes)
    end

    def nearest_food(point : Point)
      list = {} of Int64 => Array(Point)
      food.each do |pos|
        list[pos.distance_to(point)] ||= [] of Point
        list[pos.distance_to(point)] << pos
      end
      distance = list.keys.sort.first
      list[distance].sample
    end

    def blocked?(point : Point)
      return true if point.x < 0 || point.y < 0
      return true if point.x >= self.width || point.y >= self.height

      snakes.find do |snake|
        snake.body.find do |part|
          point == part
        end
      end
    end
  end

  class BattleField
    JSON.mapping(
      game: { type: Game },
      turn: Int64,
      board: { type: Board },
      you: { type: Snake }
    )

    def next_turn
      target = board.nearest_food(you.head)
      direction = you.head.direction_of(target).find do |dir|
        !board.blocked?(you.head + DIRECTIONS[dir])
      end

      { move: direction }
    end
  end
end

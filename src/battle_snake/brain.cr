require "json"
require "./math"

module BattleSnake
  DIRECTIONS = %w[up right down left]

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

    def blocked?(point : Point)
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
      { move: DIRECTIONS.sample }
    end
  end
end

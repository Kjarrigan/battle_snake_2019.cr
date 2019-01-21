require "json"

module BattleSnake
  DIRECTIONS = %w[up right down left]

  class Game
    JSON.mapping( id: String )
  end

  class Point
    JSON.mapping( x: Int64, y: Int64 )
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

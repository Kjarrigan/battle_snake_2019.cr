require "./spec_helper"

describe BattleSnake::Point do
  it "parses JSON" do
    a = BattleSnake::Point.from_json(%q[{"x": 3, "y": 4}])
    a.x.should eq(3)
    a.y.should eq(4)
  end

  it "is comparable" do
    a = BattleSnake::Point.from_json(%q[{"x": 3, "y": 4}])
    b = BattleSnake::Point.new(3, 4)
    a.should eq(b)
  end

  it "has a magnitude" do
    b = BattleSnake::Point.new(3, 4)
    b.magnitude.should eq(7)
  end

  it "has a distance to other points" do
    a = BattleSnake::Point.from_json(%q[{"x": 3, "y": 4}])
    b = BattleSnake::Point.new(3, 4)
    a.distance_to(b).should eq(0)
    b.distance_to(a).should eq(0)

    c = BattleSnake::Point.new(0, 4)
    a.distance_to(c).should eq(3)
    c.distance_to(a).should eq(3)
  end
end

describe BattleSnake::Board do
  it "knows the nearest foods position" do
    reference_point = BattleSnake::Point.new(0, 0)

    a = BattleSnake::Point.new(3, 4)
    b = BattleSnake::Point.new(0, 2)
    board = BattleSnake::Board.new width: 11, height: 11, snakes: Array(BattleSnake::Snake).new, food: [ a, b ]
    board.nearest_food(reference_point).should eq(b)

    board = BattleSnake::Board.new width: 11, height: 11, snakes: Array(BattleSnake::Snake).new, food: [ a, b, b, b ]
    board.nearest_food(reference_point).should eq(b)
  end
end

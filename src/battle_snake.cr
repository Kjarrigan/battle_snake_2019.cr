require "json"
require "router"
require "./battle_snake/brain"

module BattleSnake
  class WebServer
    include Router

    def draw_routes
      # Just for testing if the snake is up
      get "/" do |context, params|
        context.response.print "BattleSnake 2019 (c) Kjarrigan"
        context
      end

      post "/start" do |context, params|
        if io = context.request.body
          print "New game started: "
          p battle_field = BattleField.from_json(io)
        end
        context.response.puts({ color: "ffffff" }.to_json)
        context
      end

      post "/move" do |context, params|
        if io = context.request.body
          context.response.puts BattleField.from_json(io).next_turn.to_json
        end
        context
      end

      post "/end" do |context, params|
        if io = context.request.body
          print "Game ended: "
          p battle_field = BattleField.from_json(io)
          File.open("/tmp/games_history.txt", "a+") do |file|
            puts battle_field.reply_link
            file.puts battle_field.reply_link
          end
        end
        context
      end

      post "/ping" do |context, params|
        context
      end
    end

    def run
      server = HTTP::Server.new(route_handler)
      server.bind_tcp "0.0.0.0", 1234
      server.listen
    end
  end
end

if __FILE__ == PROGRAM_NAME
  web_server = BattleSnake::WebServer.new
  web_server.draw_routes
  web_server.run
end

# {
#   "game": {
#     "id": "game-id-string"
#   },
#   "turn": 4,
#   "board":
#   {
#     "height": 15,
#     "width": 15,
#     "food": [
#       { "x": 1, "y": 3 }
#     ],
#     "snakes": [
#       {
#         "id": "snake-id-string",
#         "name": "Sneky Snek",
#         "health": 90,
#         "body": [
#           { "x": 1, "y": 3 }
#         ]
#       }
#     ]
#   },
#   "you": {
#     "id": "snake-id-string",
#     "name": "Sneky Snek",
#     "health": 90,
#     "body": [
#       { "x": 1, "y": 3 }
#     ]
#   }
# }

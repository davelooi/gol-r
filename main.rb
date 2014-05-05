require './gameoflife'

def main
  game = GameOfLife.new
  game.pp
  5.times{
    sleep 1
    game.tick
    game.pp
  }
end

main
require './gameoflife'

def main (step=100,delay=0.3)
  game = GameOfLife.new
  pp game.grid
  puts "Step : 0 / #{step}"
  (1..step).each do |s|
    sleep delay
    game.tick
    pp game.grid
    puts "Step : #{s} / #{step}"
  end
end

def pp grid
  system "clear"
  grid.each do |row|
    row.each do |col|
      col == 1 ? print('x') : print(' ')
    end
    print "\n"
  end
end


main
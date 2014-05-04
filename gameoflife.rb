###########
# LIFE
###########

class Life
  def initialize (row=0,col=0,alive=randomAlive)
    @row = row
    @col = col
    @alive = alive
  end

  def randomAlive
    rand(10) == 0 ? true : false
  end

  def isAlive?
    !!@alive
  end

  def to_s
    @alive ? '1' : ' '
  end

  def nextState grid
    aN = self.aliveNeighboursCount grid
    if aN == 3
      # Rule 2
      return true
    elsif aN == 2 and self.isAlive?
      # Rule 4
      return true        
    else
      # Rule 1 and Rule 3
      return false
    end
  end

  def aliveNeighboursCount grid
    #     col
    # row (-1,1)  (0,1)     (1,1)
    #     (-1,0)  (row,col) (1,0)
    #     (-1,-1) (0,-1)    (1,-1)
    aNC = 0
    (-1..1).each do |y|
      (-1..1).each do |x|
        # Dont count myself
        next if x==0 and y==0
        
        ### Out of Bound ###
        next if @row+y < 0
        next if @col+x < 0
        next if @row+y > grid.count-1
        next if @col+x > grid[@row].count-1

        # Count
        aNC+=1 if grid[@row+y][@col+x].isAlive?
      end
    end
    return aNC
  end
end

############
# GAME
############

class GameOfLife
  attr_accessor :grid

  def initialize(row=50, col=50)
    @grid = Array.new(row) {
      |rowIndex| Array.new(col) {
        |colIndex| Life.new(rowIndex, colIndex)
      } 
    }
    @next = Array.new(row) { Array.new(col) }
    @row = row
    @col = col
  end

  def tick
    (0..@row-1).each do |y|
      (0..@col-1).each do |x|
        # apply rules on each life
        @next[y][x] = Life.new(y,x,@grid[y][x].nextState(grid))
      end
    end
    @grid = @next
  end
end


###########
# Helpers
###########

def pp grid
  system "clear"
  grid.each do |row|
    row.each do |col|
      print col
    end
    print "\n"
  end
end

#######
# START
#######
game = GameOfLife.new
pp game.grid
5.times{
  sleep 1
  game.tick
  pp game.grid
}




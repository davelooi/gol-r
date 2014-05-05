###########
# LIFE
###########

class Life
  def initialize (alive=randomAlive)
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

  def nextState (aliveNeighbours)
    if aliveNeighbours == 3
      # Rule 2
      return true
    elsif aliveNeighbours == 2 and self.isAlive?
      # Rule 4
      return true        
    else
      # Rule 1 and Rule 3
      return false
    end
  end
end

#############
# GRID
#############
class GridOfLife
  attr_accessor :grid

  def initialize(row,col,createLife=true)
    @row = row
    @col = col
    @grid = Array.new(@row) {
      |rowIndex| Array.new(@col) {
        |colIndex| Life.new if createLife
      } 
    }
    @next = Array.new(@row) { Array.new(@col) }
  end

  def tick
    (0..@row-1).each do |y|
      (0..@col-1).each do |x|
        # apply rules on each life
        @next[y][x] = Life.new(@grid[y][x].nextState(countLiveNeighbours(y,x)))
      end
    end
    @grid = @next
  end

  def countLiveNeighbours (row,col)
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
        next if row+y < 0
        next if col+x < 0
        next if row+y > @grid.count-1
        next if col+x > @grid[row].count-1

        # Count
        aNC+=1 if @grid[row+y][col+x].isAlive?
      end
    end
    return aNC
  end

  def pp
    system "clear"
    @grid.each do |row|
      row.each do |col|
        print col
      end
      print "\n"
    end
  end
end

############
# GAME
############

class GameOfLife
  def initialize(row=50, col=50)
    @grid = GridOfLife.new(row,col,true)
  end

  def tick
    @grid.tick
  end

  def pp
    @grid.pp
  end

end


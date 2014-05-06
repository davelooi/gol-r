class GameOfLife
  attr_accessor :grid

  ### NEW
  def initialize(row=50,col=50,random=true,fillGrid=1)
    @row = row
    @col = col
    @grid = Array.new(@row) { 
      Array.new(@col) {
        if random
          randomAlive
        else
          fillGrid
        end
      }
    }
    @next = Array.new(@row) { Array.new(@col) }
  end

  def randomAlive
    rand(10) == 0 ? 1 : 0
  end

  ### PLAY
  def tick
    (0..@row-1).each do |y|
      (0..@col-1).each do |x|
        # apply rules on each life
        @next[y][x] = nextState(y,x)
      end
    end
    @grid = @next
  end

  def nextState (row,col)
    applyRule(
      countLiveNeighbours(row,col),
      isAlive?(row,col)
    ) ? 1 : 0
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
        
        ### Borders ###
        next if row+y < 0
        next if col+x < 0
        next if row+y > @grid.count-1
        next if col+x > @grid[row].count-1

        # Count
        aNC+=1 if isAlive?(row+y,col+x)
      end
    end
    return aNC
  end

  def applyRule (aliveNeighbours,isAlive)
    # Rule 2
    if aliveNeighbours == 3
      return true

    # Rule 4
    elsif aliveNeighbours == 2 and isAlive
      return true

    # Rule 1 and Rule 3
    else
      return false
    end
  end

  ### STATE
  def isAlive?(row,col)
    return !@grid[row][col].zero?
  end
end

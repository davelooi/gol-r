require './gameoflife'

## Life
describe Life do
  context "new" do
    it "should create a new Life" do
      life = Life.new
      expect(life.is_a?(Life)).to be_true
    end
  end

  context "alive" do
    subject(:alive) { Life.new(0,0,true) }
    it "should be alive" do
      expect(alive.isAlive?).to be_true
    end
    it "return '1'" do
      alive.to_s.should == '1'
    end
  end

  context "dead" do
    subject(:dead) { Life.new(0,0,false) }
    it "should be dead" do
      expect(dead.isAlive?).to be_false
    end
    it "should return ' '" do
      dead.to_s.should == ' '
    end
  end

  context "aliveNeighboursCount with all live neighbours" do
    let(:grid) { 
      Array.new(3) { 
        |rowIndex| Array.new(3) { 
          |colIndex| Life.new(rowIndex, colIndex, true) 
        } 
      } 
    }
    it "should count 8 live neighbours" do
      grid[1][1].aliveNeighboursCount(grid).should == 8
    end
  end

  context "aliveNeighboursCount with all dead neighbours" do
    let(:grid) { 
      Array.new(3) { 
        |rowIndex| Array.new(3) { 
          |colIndex| Life.new(rowIndex, colIndex, false) 
        } 
      } 
    }
    it "should count 0 live neighbours" do
      grid[1][1].aliveNeighboursCount(grid).should == 0
    end
  end

  context "rule 1" do
    let(:grid) { 
      Array.new(3) { 
        |rowIndex| Array.new(3) { 
          |colIndex| Life.new(rowIndex, colIndex, false) 
        } 
      } 
    }
    it "should die with fewer than 0 live neighbour" do
      grid[1][1] = Life.new(1,1,true) # alive
      expect(grid[1][1].isAlive?).to be_true
      expect(grid[1][1].nextState(grid)).to be_false
    end
    it "should die with fewer than 1 live neighbour" do
      grid[1][1] = Life.new(1,1,true) # alive
      grid[0][0] = Life.new(0,0,true)
      expect(grid[1][1].isAlive?).to be_true
      expect(grid[1][1].nextState(grid)).to be_false
    end
  end

  context "rule 2" do
    let(:grid) { 
      Array.new(3) { 
        |rowIndex| Array.new(3) { 
          |colIndex| Life.new(rowIndex, colIndex, false) 
        } 
      } 
    }
    it "should stay alive with 2 live neighbour" do
      grid[1][1] = Life.new(1,1,true) # alive
      grid[0][0] = Life.new(0,0,true)
      grid[2][2] = Life.new(2,2,true)
      expect(grid[1][1].isAlive?).to be_true
      expect(grid[1][1].nextState(grid)).to be_true
    end
    it "should stay alive with 3 live neighbour" do
      grid[1][1] = Life.new(1,1,true) # alive
      grid[0][0] = Life.new(0,0,true)
      grid[2][2] = Life.new(2,2,true)
      grid[0][2] = Life.new(0,2,true)
      expect(grid[1][1].isAlive?).to be_true
      expect(grid[1][1].nextState(grid)).to be_true
    end
  end
  context "rule 3" do
    let(:grid) { 
      Array.new(3) { 
        |rowIndex| Array.new(3) { 
          |colIndex| Life.new(rowIndex, colIndex, false) 
        } 
      } 
    }
    it "should die with 4 or more live neighbour" do
      grid[1][1] = Life.new(1,1,true) # alive
      grid[0][0] = Life.new(0,0,true)
      grid[0][1] = Life.new(0,1,true)
      grid[0][2] = Life.new(0,2,true)
      grid[1][0] = Life.new(1,0,true)
      expect(grid[1][1].isAlive?).to be_true
      expect(grid[1][1].nextState(grid)).to be_false
    end
    let(:grid) { 
      Array.new(3) { 
        |rowIndex| Array.new(3) { 
          |colIndex| Life.new(rowIndex, colIndex, true)
        } 
      } 
    }
    it "should die with 8 alive neighbours" do
      grid[1][1] = Life.new(1,1,true) # alive
      grid[1][1].aliveNeighboursCount(grid).should == 8
      expect(grid[1][1].isAlive?).to be_true
      expect(grid[1][1].nextState(grid)).to be_false
    end
  end
  context "rule 4" do
    let(:grid) { 
      Array.new(3) { 
        |rowIndex| Array.new(3) { 
          |colIndex| Life.new(rowIndex, colIndex, false) 
        } 
      } 
    }
    it "should comes back to live with 3 neighbours" do
      grid[1][1] = Life.new(1,1,false) # dead
      grid[0][0] = Life.new(0,0,true)
      grid[2][2] = Life.new(2,2,true)
      grid[0][2] = Life.new(0,2,true)
      expect(grid[1][1].isAlive?).to be_false
      expect(grid[1][1].nextState(grid)).to be_true
    end
  end
end

## Game
describe GameOfLife do
  context "new" do
    it "should create a new game" do
      game = GameOfLife.new
      expect(game.is_a?(GameOfLife)).to be_true
    end
  end
end


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
    subject(:alive) { Life.new(true) }
    it "should be alive" do
      expect(alive.isAlive?).to be_true
    end
    it "return '1'" do
      alive.to_s.should == '1'
    end
  end

  context "dead" do
    subject(:dead) { Life.new(false) }
    it "should be dead" do
      expect(dead.isAlive?).to be_false
    end
    it "should return ' '" do
      dead.to_s.should == ' '
    end
  end

  context "RULE 1; alive" do
    let(:life) { Life.new(true) }
    it "should die with 0 and 1 live neighbour" do
      expect(life.nextState(0)).to be_false
    end
    it "should die with fewer than 1 live neighbour" do
      expect(life.nextState(1)).to be_false
    end
  end

  context "RULE 2; alive" do
    let(:life) { Life.new(true) }
    it "should stay alive with 2 live neighbour" do
      expect(life.nextState(2)).to be_true
    end
    it "should stay alive with 3 live neighbour" do
      expect(life.nextState(3)).to be_true
    end
  end
  context "RULE 3; alive" do
    let(:life) { Life.new(true) }
    it "should die with 4 or more live neighbour" do
      expect(life.nextState(4)).to be_false
    end
    it "should die with 8 alive neighbours" do
      expect(life.nextState(8)).to be_false
    end
  end
  context "RULE 4; dead" do
    let(:life) { Life.new(false) }
    it "should comes back to live with 3 neighbours" do
      expect(life.nextState(3)).to be_true
    end
    it "should stay dead with 0 neighbours" do
      expect(life.nextState(0)).to be_false
    end
    it "should stay dead with 2 neighbours" do
      expect(life.nextState(2)).to be_false
    end
    it "should stay dead with 4 neighbours" do
      expect(life.nextState(4)).to be_false
    end
    it "should stay dead with 8 neighbours" do
      expect(life.nextState(8)).to be_false
    end
  end
end

## Grid
describe GridOfLife do
  context "new" do
    it "should create a new Grid" do
      grid = GridOfLife.new(3,3)
      expect(grid.is_a?(GridOfLife)).to be_true
    end
  end

  context "countLiveNeighbours" do
    before(:all) do
      @grid = GridOfLife.new(3,3,false)
      (0..2).each do |row|
        (0..2).each do |col|
          @grid.grid[row][col] = Life.new(true)
        end
      end
    end
    it "should not exceed corner boundary" do
      @grid.countLiveNeighbours(0,0).should == 3
      @grid.countLiveNeighbours(0,2).should == 3
      @grid.countLiveNeighbours(2,0).should == 3
      @grid.countLiveNeighbours(2,2).should == 3
    end
    it "should not exceed mid boundary" do
      @grid.countLiveNeighbours(0,1).should == 5
      @grid.countLiveNeighbours(1,0).should == 5
      @grid.countLiveNeighbours(1,2).should == 5
      @grid.countLiveNeighbours(2,1).should == 5
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


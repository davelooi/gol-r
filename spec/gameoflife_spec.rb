require './gameoflife'

describe GameOfLife do
  #################
  # GAME
  #################
  context "when new" do
    it "should create a new Game" do
      game = GameOfLife.new
      expect(game.is_a?(GameOfLife)).to be_true
    end
  end

  ### Life
  context "when alive" do
    subject(:game) { GameOfLife.new(1,1,false,1) }
    it "should be alive" do
      expect(game.isAlive?(0,0)).to be_true
    end
  end

  context "when dead" do
    subject(:game) { GameOfLife.new(1,1,false,0) }
    it "should be dead" do
      expect(game.isAlive?(0,0)).to be_false
    end
  end

  ### Rules
  context "RULE 1; alive" do
    let(:game) { GameOfLife.new() }
    it "should die with 0 and 1 live neighbour" do
      expect(game.applyRule(0,true)).to be_false
    end
    it "should die with fewer than 1 live neighbour" do
      expect(game.applyRule(1,true)).to be_false
    end
  end
  context "RULE 2; alive" do
    let(:game) { GameOfLife.new() }
    it "should stay alive with 2 live neighbour" do
      expect(game.applyRule(2,true)).to be_true
    end
    it "should stay alive with 3 live neighbour" do
      expect(game.applyRule(3,true)).to be_true
    end
  end
  context "RULE 3; alive" do
    let(:game) { GameOfLife.new() }
    it "should die with 4 or more live neighbour" do
      expect(game.applyRule(4,true)).to be_false
    end
    it "should die with 8 alive neighbours" do
      expect(game.applyRule(8,true)).to be_false
    end
  end
  context "RULE 4; dead" do
    let(:game) { GameOfLife.new() }
    it "should comes back to live with 3 neighbours" do
      expect(game.applyRule(3,false)).to be_true
    end
    it "should stay dead with 0 neighbours" do
      expect(game.applyRule(0,false)).to be_false
    end
    it "should stay dead with 2 neighbours" do
      expect(game.applyRule(2,false)).to be_false
    end
    it "should stay dead with 4 neighbours" do
      expect(game.applyRule(4,false)).to be_false
    end
    it "should stay dead with 8 neighbours" do
      expect(game.applyRule(8,false)).to be_false
    end
  end

  ### COUNT NEIGHBOURS
  context "countLiveNeighbours" do
    let(:game) { GameOfLife.new(3,3,false,1) }
    it "should not exceed corner boundary" do
      game.countLiveNeighbours(0,0).should == 3
      game.countLiveNeighbours(0,2).should == 3
      game.countLiveNeighbours(2,0).should == 3
      game.countLiveNeighbours(2,2).should == 3
    end
    it "should not exceed mid boundary" do
      game.countLiveNeighbours(0,1).should == 5
      game.countLiveNeighbours(1,0).should == 5
      game.countLiveNeighbours(1,2).should == 5
      game.countLiveNeighbours(2,1).should == 5
    end
    it "should count 8 with all alive neighbours" do
      game.countLiveNeighbours(1,1).should == 8
    end
  end

  ### TICK
  # examples from Conway's Game of Life wiki
  context "Still Life" do
    context "Block" do
      let(:game) { GameOfLife.new(4,4) }
      it "should stay still" do
        game.grid = [[0,0,0,0],
                     [0,1,1,0],
                     [0,1,1,0],
                     [0,0,0,0]]
        expected = game.grid
        game.tick
        game.grid.should == expected
      end
    end
    context "Beehive" do
      let(:game) { GameOfLife.new(5,6) }
      it "should stay still" do
        game.grid = [[0,0,0,0,0,0],
                     [0,0,1,1,0,0],
                     [0,1,0,0,1,0],
                     [0,0,1,1,0,0],
                     [0,0,0,0,0,0]]
        expected = game.grid
        game.tick
        game.grid.should == expected
      end
    end
    context "Loaf" do
      let(:game) { GameOfLife.new(6,6) }
      it "should stay still" do
        game.grid = [[0,0,0,0,0,0],
                     [0,0,1,1,0,0],
                     [0,1,0,0,1,0],
                     [0,0,1,0,1,0],
                     [0,0,0,1,0,0],
                     [0,0,0,0,0,0]]
        expected = game.grid
        game.tick
        game.grid.should == expected
      end
    end
    context "Boat" do
      let(:game) { GameOfLife.new(5,5) }
      it "should stay still" do
        game.grid = [[0,0,0,0,0],
                     [0,1,1,0,0],
                     [0,1,0,1,0],
                     [0,0,1,0,0],
                     [0,0,0,0,0]]
        expected = game.grid
        game.tick
        game.grid.should == expected
      end
    end
  end

  context "Oscillators Life" do
    context "Blinker" do
      let(:game) { GameOfLife.new(5,5) }
      it "should oscillate" do
        game.grid = [[0,0,0,0,0],
                     [0,0,1,0,0],
                     [0,0,1,0,0],
                     [0,0,1,0,0],
                     [0,0,0,0,0]]
        expected  = [[0,0,0,0,0],
                     [0,0,0,0,0],
                     [0,1,1,1,0],
                     [0,0,0,0,0],
                     [0,0,0,0,0]]
        game.tick
        game.grid.should == expected
      end
    end
    context "Toad" do
      let(:game) { GameOfLife.new(6,6) }
      it "should oscillate" do
        game.grid = [[0,0,0,0,0,0],
                     [0,0,0,1,0,0],
                     [0,1,0,0,1,0],
                     [0,1,0,0,1,0],
                     [0,0,1,0,0,0],
                     [0,0,0,0,0,0]]
        expected  = [[0,0,0,0,0,0],
                     [0,0,0,0,0,0],
                     [0,0,1,1,1,0],
                     [0,1,1,1,0,0],
                     [0,0,0,0,0,0],
                     [0,0,0,0,0,0]]
        game.tick
        game.grid.should == expected
      end
    end
    context "Beacon" do
      let(:game) { GameOfLife.new(6,6) }
      it "should oscillate" do
        game.grid = [[0,0,0,0,0,0],
                     [0,1,1,0,0,0],
                     [0,1,1,0,0,0],
                     [0,0,0,1,1,0],
                     [0,0,0,1,1,0],
                     [0,0,0,0,0,0]]
        expected  = [[0,0,0,0,0,0],
                     [0,1,1,0,0,0],
                     [0,1,0,0,0,0],
                     [0,0,0,0,1,0],
                     [0,0,0,1,1,0],
                     [0,0,0,0,0,0]]
        game.tick
        game.grid.should == expected
      end
    end
  end
end

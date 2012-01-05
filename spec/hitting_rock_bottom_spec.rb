require 'spec_helper'
require 'hitting_rock_bottom'
require 'pp'

describe HittingRockBottom do

  before :each do
    @o = HittingRockBottom.new(File.expand_path(File.dirname(__FILE__)) + '/fixtures/simple_cave.txt')
  end

  it "should load the cave from file on initalization" do

    @o.cave.should == [
      "################################\n",
      "~                              #\n",
      "#         ####                 #\n",
      "###       ####                ##\n",
      "###       ####              ####\n",
      "#######   #######         ######\n",
      "#######   ###########     ######\n",
      "################################\n"
    ]

    @o.units.should == 44

  end

  it "should find next postion for water" do

    cave1_last_pos = { :col => 0, :row => 1 }
    cave1 = [
      "################################\n",
      "~                              #\n",
      "#         ####                 #\n",
      "###       ####                ##\n",
      "###       ####              ####\n",
      "#######   #######         ######\n",
      "#######   ###########     ######\n",
      "################################\n"
    ]

    @o.next_position(cave1,cave1_last_pos).should == { :col => 1, :row => 1 }


    cave2_last_pos = { :col => 1, :row => 1 }
    cave2 = [
      "################################\n",
      "~~                             #\n",
      "#         ####                 #\n",
      "###       ####                ##\n",
      "###       ####              ####\n",
      "#######   #######         ######\n",
      "#######   ###########     ######\n",
      "################################\n"
    ]

    @o.next_position(cave2,cave2_last_pos).should == { :col => 1, :row => 2 }


    cave3_last_pos = { :col => 9, :row => 6 }
    cave3 = [
      "################################\n",
      "~~                             #\n",
      "#~        ####                 #\n",
      "###~      ####                ##\n",
      "###~~~~~  ####              ####\n",
      "#######~  #######         ######\n",
      "#######~~~###########     ######\n",
      "################################\n"
    ]

    @o.next_position(cave3,cave3_last_pos).should == { :col => 8, :row => 5 }

  end

  it "should fill water properly" do

    @o.fill_water.should == [
      "################################\n",
      "~~~~~~~~~~~~~~~                #\n",
      "#~~~~~~~~~####~                #\n",
      "###~~~~~~~####                ##\n",
      "###~~~~~~~####              ####\n",
      "#######~~~#######         ######\n",
      "#######~~~###########     ######\n",
      "################################\n"
    ]

    @o100 = HittingRockBottom.new(File.expand_path(File.dirname(__FILE__)) + '/fixtures/simple_cave_100.txt')
    @o100.fill_water.should == [
      "################################\n",
      "~~~~~~~~~~~~~~~                #\n",
      "#~~~~~~~~~####~~~~~~~~~~~~     #\n",
      "###~~~~~~~####~~~~~~~~~~~~~~~~##\n",
      "###~~~~~~~####~~~~~~~~~~~~~~####\n",
      "#######~~~#######~~~~~~~~~######\n",
      "#######~~~###########~~~~~######\n",
      "################################\n"
    ]

  end

  it "should find water depth" do
    @o100 = HittingRockBottom.new(File.expand_path(File.dirname(__FILE__)) + '/fixtures/simple_cave_100.txt')
    @o100.water_depth.should == "1 2 2 4 4 4 4 6 6 6 1 1 1 1 4 3 3 4 4 4 4 5 5 5 5 5 2 2 1 1 0 0"

    @o45 = HittingRockBottom.new(File.expand_path(File.dirname(__FILE__)) + '/fixtures/simple_cave.txt')
    @o45.water_depth.should == "1 2 2 4 4 4 4 6 6 6 1 1 1 1 ~ 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0"
  end

  it "should depth in a complex cave" do
    @complex = HittingRockBottom.new(File.expand_path(File.dirname(__FILE__)) + '/fixtures/complex_cave.txt')
    @complex.water_depth.should == "1 12 1 5 8 8 9 10 17 17 18 20 24 24 24 24 24 24 32 32 32 32 32 32 32 32 9 5 1 1 9 11 29 30 32 32 32 32 32 22 20 19 18 13 10 10 8 4 4 3 3 19 19 20 21 23 23 24 24 26 32 32 32 32 32 32 32 22 22 22 21 21 21 6 6 2 1 1 1 1 1 1 1 32 30 30 30 8 8 5 5 2 2 2 8 19 19 19 20 21 26 26 27 28 28 29 29 30 30 30 30 30 30 30 30 30 30 30 30 30 17 16 15 15 15 11 8 8 6 6 6 1 1 1 1 ~ 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0"
  end



end
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



end
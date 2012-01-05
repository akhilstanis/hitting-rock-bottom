class HittingRockBottom

  attr_accessor :cave, :units, :last_unit

  def initialize path_to_cave_file
    File.open path_to_cave_file, "r" do |file|
      @cave = file.readlines
    end
    @units = @cave.shift(2).first.to_i - 1
    @last_unit = { :col => 0, :row => 1 }
  end

  def next_position arg_cave=nil, arg_last_unit=nil
    cave = arg_cave || @cave
    last_unit = arg_last_unit || @last_unit
    if cave[last_unit[:row]+1][last_unit[:col]] == " "
      last_unit[:row] += 1
    elsif cave[last_unit[:row]][last_unit[:col]+1] == " "
      last_unit[:col] += 1
    elsif cave[last_unit[:row]-1][last_unit[:col]] == " "
      last_unit[:row] -= 1
      last_unit[:col] = cave[last_unit[:row]].index ' '
    end
    last_unit
  end

  def fill_water
    while @units > 0 do
      next_unit = next_position
      @cave[next_unit[:row]][next_unit[:col]] = "~"
      @last_unit = next_unit
      @units -= 1
    end
    @cave
  end

end
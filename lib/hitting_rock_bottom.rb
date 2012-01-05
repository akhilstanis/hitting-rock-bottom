class HittingRockBottom

  attr_accessor :cave, :units, :last_unit

  def initialize path_to_cave_file
    File.open path_to_cave_file, "r" do |file|
      @cave = file.readlines
    end
    @output_file = "#{File.dirname(path_to_cave_file)}/#{File.basename(path_to_cave_file).split('.').insert(1,'_output.').join}"
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

  def water_depth
    fill_water
    depth = ""
    (@cave.first.size-1).times do |col|
      col_depth = 0
      @cave.each do |row|
        col_depth += 1 if row[col] == "~"
        if col_depth > 1 && row[col] == ' '
          col_depth = "~"
          break
        end
      end
      depth += col_depth.to_s + " "
    end
    File.open @output_file, "w" do |file|
      file.write depth.chop + "\n"
    end
    depth.chop
  end

end
class GraphData
  attr_reader :filename

  def initialize(filename)
    @filename = filename
  end

  def data
    @data ||= begin
      if File.exists?(filename)
        parse_file(filename)
      else
        fail "Cannot find file named #{filename}"
      end
    end
  end

  def all_points
    @all_points ||= data.map { |data_set| [data_set[:starting_point], data_set[:ending_point]] }.flatten!.uniq
  end

  def unvisited_neighbors_for_point(point, unvisited_points)
    data.select { |data_set| (data_set[:starting_point] == point) && (unvisited_points.include? data_set[:ending_point]) }
  end

  private

  def parse_file(filename)
    data = []

    File.open(filename).each do |line|
      line_array = line.chomp.tr('[]', '').split(',')

      line_hash = Hash.new.tap do |hsh|
        hsh[:starting_point] = line_array[0]
        hsh[:ending_point]   = line_array[1]
        hsh[:distance]       = line_array[2].to_i
      end

      data << line_hash
    end

    data
  end
end

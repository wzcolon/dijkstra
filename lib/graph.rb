class Graph
  attr_reader :filename, :start_point, :end_point

  def initialize(filename, start_point, end_point)
    @filename = filename
    @start_point = start_point
    @end_point = end_point
  end

  def traverse
    Traverser.new(self).run
  end

  def all_points
    @all_points ||= edges.map { |edge| [edge[:starting_point], edge[:ending_point]] }.flatten!.uniq
  end

  def unvisited_neighbors_for_point(point, unvisited_points)
    edges.select { |edge| (edge[:starting_point] == point) && (unvisited_points.include? edge[:ending_point]) }
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

  def edges
    @edges ||= begin
      if File.exists?(filename)
        parse_file(filename)
      else
        fail "Cannot find file named #{filename}"
      end
    end
  end
end

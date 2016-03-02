class Traverser
  attr_reader :graph,
              :visited,
              :unvisited,
              :point_values,
              :current_point

  def initialize(graph)
    @graph = graph
    @current_point = graph.start_point
    @visited = [current_point]
    @unvisited = graph.all_points - visited
  end

  def run
    set_initial_point_values

    while current_point != graph.end_point
      @current_point = begin
        options = graph.unvisited_neighbors_for_point(current_point, unvisited)

        update_point_values(options)
        chosen_option = choose_next_point(options)
        move_point_to_visited(chosen_option)
      end
    end

    puts "Shortest path is #{shortest_path} with total cost #{point_values[graph.end_point][:value]}"
    puts "Visited points were #{visited}"
  end

  private

  def set_initial_point_values
    @point_values = graph.all_points.each_with_object({}) do |point, hsh|
      if point == graph.start_point
        hsh[point] = { value: 0, previous: graph.start_point }
      else
        hsh[point] = { value: Float::INFINITY, previous: graph.start_point }
      end
    end
  end

  def update_point_values(options)
    options.each do |option|
      current_endpoint_value = point_values[option[:ending_point]][:value]
      calculated_value = point_values[current_point][:value] + option[:distance]

      if calculated_value < current_endpoint_value
        point_values[option[:ending_point]] = { value: calculated_value, previous: current_point }
      end
    end
  end

  def choose_next_point(options)
    option_values = options.each_with_object({}) do |option, hsh|
      hsh[option[:ending_point]] = point_values[option[:ending_point]][:value]
    end

    Hash[option_values.sort_by { |_, v| v }].first[0]
  end

  def move_point_to_visited(point)
    unvisited.delete(point)
    visited << point
    point
  end

  def shortest_path
    path = [graph.end_point]

    while path[0] != graph.start_point
      previous_point = point_values[path[0]][:previous]
      path.unshift(previous_point)
    end

    path
  end
end

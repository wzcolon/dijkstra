require './lib/graph_data'

class Dijkstra
  attr_reader :start_point,
              :end_point,
              :graph_data,
              :visited,
              :unvisited,
              :point_values

  def initialize(filename, start_point, end_point)
    @start_point = start_point
    @end_point = end_point
    @graph_data ||= GraphData.new(filename)
    @visited = [start_point]
    @unvisited = graph_data.all_points - visited
  end

  def run
    set_initial_point_values
    current_point = start_point

    while current_point != end_point
      current_point = choose_best_path(current_point)
    end

    puts "Shortest path is #{shortest_path} with total cost #{point_values[end_point][:value]}"
    puts "Visited points were #{visited}"
  end

  private

  def set_initial_point_values
    @point_values = graph_data.all_points.each_with_object({}) do |point, hsh|
      if point == start_point
        hsh[point] = { value: 0, from: start_point }
      else
        hsh[point] = { value: Float::INFINITY, from: start_point }
      end
    end
  end

  def choose_best_path(current_point)
    options = graph_data.unvisited_neighbors_for_point(current_point, unvisited)

    options.each do |option|
      current_endpoint_value = point_values[option[:ending_point]][:value]
      calculated_value = point_values[current_point][:value] + option[:distance]

      if calculated_value < current_endpoint_value
        point_values[option[:ending_point]] = { value: calculated_value, from: current_point }
      end
    end

    option_values = options.each_with_object({}) do |option, hsh|
      hsh[option[:ending_point]] = point_values[option[:ending_point]][:value]
    end

    # TODO make this not suck
    chosen_option = Hash[option_values.sort_by { |_, v| v }].first[0]

    move_point_to_visited(chosen_option)
  end

  def move_point_to_visited(point)
    unvisited.delete(point)
    visited << point
    point
  end

  def shortest_path
    path = [end_point]
    point = end_point

    while point != start_point
      point = point_values[point][:from]
      path.unshift(point)
    end

    path
  end
end

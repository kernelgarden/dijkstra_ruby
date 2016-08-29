require 'pqueue'

class Dijkstra

  def initialize(edges, weights, n)
    @edges = edges
    @weights = weights
    @n = n
    clean_up
  end

  def clean_up
    @infinity = 1 << 32
    @visited = Array.new(@n, false)
    @shortest_distances = Array.new(@n, @infinity)
    @previous = Array.new(@n, nil)
    @pq = PQueue.new(){|x, y| @shortest_distances[x] < @shortest_distances[y]}
  end

  def compute(source)
    @source = source
    @pq.push(source)
    @visited[source] = true
    @shortest_distances[source] = 0

    while @pq.size != 0
      v = @pq.pop
      @visited[v] = true
      if @edges[v] != []
        @edges[v].each do |w|
          if !@visited[w] and @shortest_distances[w] > @shortest_distances[v] + @weights[v][w]
            @shortest_distances[w] = @shortest_distances[v] + @weights[v][w]
            @previous[w] = v
            @pq.push(w)
          end
        end
      end
    end

    return [@shortest_distances, @previous]
  end

  def get_passed_path(destination)
    passed_paths = Array.new()
    passed_paths.push(@previous[destination])

    while passed_paths.last != @source
      passed_paths.push(@previous[passed_paths.last])
    end

    return passed_paths
  end

  def make_edges(n)
    edges = Array.new(n){ Array.new() }
    
  end

  def make_weights(n)
    weights = Array.new(n){ Array.new(n, 1 << 32) }
  end
end

n = 9
# edeges[vertex_index][order]
edges = Array.new(n){ Array.new() }
edges[0][0] = 4
edges[1][0] = 0
edges[1][1] = 5
edges[1][2] = 2 
edges[2][0] = 5
edges[2][1] = 6
edges[2][2] = 3
edges[4][0] = 7
edges[5][0] = 4
edges[5][1] = 7
edges[5][2] = 6
edges[6][0] = 8

# weights[from_vertex][target_vertex]
weights = Array.new(n){ Array.new(n, 1 << 32) }
weights[0][4] = 247
weights[1][0] = 35
weights[1][2] = 126
weights[1][5] = 150
weights[2][3] = 117
weights[2][6] = 220
weights[4][7] = 98
weights[5][4] = 82
weights[5][6] = 154
weights[5][7] = 120
weights[6][8] = 106

dijkstra = Dijkstra.new(edges, weights, n)
puts dijkstra.compute(1).inspect()
puts dijkstra.get_passed_path(8).inspect()
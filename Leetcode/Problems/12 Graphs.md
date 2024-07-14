## Graph Basics

**A graph is a data structure that consists of:**

- **Vertices (or Nodes)**: Points in the graph.
- **Edges**: Connections between the vertices.

**Graphs can be:**

- **Directed**: Edges have a direction (e.g., A -> B).
- **Undirected**: Edges do not have a direction (e.g., A -- B).

**Graphs can also be:**

- **Weighted**: Edges have weights (values).
- **Unweighted**: Edges do not have weights.

## Graph Algo Python 
> insert python file

### Shortest path
- Find the shortest path given `source` & `dest`
- Idea is to load it into a queue with updated distance and when `dest` is reached return the stored distance

```python
# Shortest Path
# Uses BFS to keep track of the shortest path in the queue

class ShortestPath:
    def __init__(self, edges):
        self.edges = edges
        self.graph = {}
        self.buildGraph(edges)

    def buildGraph(self, edges):
        for edge in edges:
            a, b = edge
            if a not in self.graph:
                self.graph[a] = []
            if b not in self.graph:
                self.graph[b] = []
            self.graph[a].append(b)
            self.graph[b].append(a)
        print(self.graph)
            
    def shortestPath(self, source, destination):
        queue = [ [source,0] ]
        visited = set([source])
        while queue:
            node, distance = queue.pop(0)
            if node == destination:
                print(distance)
                return distance
            for neighbour in self.graph[node]:
                if neighbour not in visited:
                    visited.add(neighbour)
                    queue.append([neighbour, distance+1])
        return -1

if __name__ == "__main__":
    edges = [
        ['w', 'x'],
        ['x', 'y'],
        ['z', 'y'],
        ['z', 'v'],
        ['w', 'v'],
    ]
    
    graph = ShortestPath(edges)
    graph.shortestPath('x', 'v') # 2
```

### Dijkstra's Algorithm

#### Dijkstra 1
- Find shortest path from one source to every other node
- return distance to every other node from `source`
- non-negative weights
- Used in network routing protocols, geographic mapping
- min-heap

#### Components

- **Graph Representation**: The graph is represented as a dictionary where keys are node identifiers, and values are dictionaries of neighbors with edge weights.
- **Priority Queue**: A min-heap is used to explore nodes in order of their current shortest distance.
- **Distance Table**: A dictionary to keep track of the shortest known distance to each node from the source.
#### Steps
1. **Initialization**:
    
    - Set the distance to the source node to 0 and all other nodes to infinity.
    - Add the source node to the priority queue with a distance of 0.
2. **Processing**:
    
    - While there are nodes in the priority queue, pop the node with the smallest distance.
    - For each neighbour of the current node, calculate the distance from the source to this neighbour.
    - If this distance is shorter than the known distance, update the distance table and add the neighbour to the priority queue with the updated distance.
3. **Termination**:
    
    - The algorithm terminates when all nodes have been processed and the shortest path to each node is known.

```python
import heapq

class Dijkstra:
    def __init__(self, graph) -> None:
        self.graph = graph

    def dijkstra(self, source):
        # Initialization
        queue = [ ]
        # Set distances to all nodes to infinity and set distances to source node to 0
        distances = { vertex: float('infinity') for vertex in self.graph }
        distances[source] = 0
        # push source node into priority queue to store (distance, vertex, )
        heapq.heappush(queue, (0, source))

        # Process
        while queue:
            currDist, currVertex = heapq.heappop(queue)
            # Skip processing if we found a longer path
            if currDist > distances[currVertex]:
                continue

            # Explore neighbours
            for neighbour, weight in self.graph[currVertex].items():
                distance = currDist + weight
                # If we find a shorter path to the neighbour, update the distance
                if distance < distances[neighbour]:
                    distances[neighbour] = distance
                    heapq.heappush(queue, (distance, neighbour))
        return distances

if __name__ == "__main__":
    graph = {
        'A': {'B': 1, 'C': 4},
        'B': {'A': 1, 'D': 2},
        'C': {'A': 4, 'D': 3},
        'D': {'B': 2, 'C': 3}
    }

    start =  'A'
    g = Dijkstra(graph)
    distances = g.dijkstra(start)
    print(distances)
```

#### Dijkstra 2
- A way to form a path from `source` to `dest`
- By using `previousNode`

```python
# Dijkrstra's Algorithm II
import heapq

class DijkrstaII:
    def __init__(self, graph):
        self.graph = graph

    def dijkstra(self, source):
        queue = []
        heapq.heappush(queue, (0, source))
        distances = { vertex: float('infinity') for vertex in self.graph }
        distances[source] = 0
        previousNodes = { vertex: None for vertex in self.graph}
        while queue:
            currDist, currVertex = heapq.heappop(queue)
            if currDist > distances[currVertex]:
                continue
            for neighbour, weight in self.graph[currVertex].items():
                distance = currDist + weight
                if distance < distances[neighbour]:
                    distances[neighbour] = distance
                    previousNodes[neighbour] = currVertex
                    heapq.heappush(queue, (distance, neighbour))
        return distances, previousNodes

    def reconstructPath(self, previousNodes, distances, start, end):
        path = []
        current = end
        while current is not None:
            path.append(current)
            current = previousNodes[current]
        path.reverse()
        if path[0] == start:
            totalDistances = distances[end]
            return path, totalDistances
        else:
            return None, float('infinity')

if __name__ == '__main__':
    
    # graph = {
    #     'A': {'B': 1, 'C': 4},
    #     'B': {'A': 1, 'D': 2},
    #     'C': {'A': 4, 'D': 3},
    #     'D': {'B': 2, 'C': 3}
    # }
    graph = {
        'A': {'B': 2, 'C': 4},
        'B': {'A': 2, 'C': 1, 'D': 7},
        'C': {'A': 4, 'B': 1, 'E': 3},
        'D': {'B': 7, 'E': 2, 'F': 3},
        'E': {'C': 3, 'D': 2, 'F': 1},
        'F': {'D': 3, 'E': 1, 'G': 5},
        'G': {'F': 5}
    }

    start = 'A'
    g = DijkrstaII(graph)
    distances, previousNodes = g.dijkstra(start)
    print(f"Shortest Distance from {start}:{distances}")
    end = 'F'
    path, totalDistances = g.reconstructPath(previousNodes, distances, start, end)
    print(f"Shortest Path from {start} to {end}: {path} with total distance {totalDistances}")
```

### Number of Islands

- Iterate through each `r,c`
- Check if `r,c` has already been visited
- If not visited, check if it is a `1`
- If we find a `1` -> island exists
    - Call a helper function to explore the island (neighbours)
    - Explore func
        - DFS
        - Add the explored r,c into visited
        - Check all 4 directions
        - If we find a `1` -> add to stack so that the attached islands can be explored
        - If we find a `0` -> we won't go towards that direction
- If we find a `0` -> continue
- **Time Complexity**: `O(m * n)`
- **Space Complexity**: `O(m * n)`

```python
# Island Count
class Island:
    def __init__(self) -> None:
        self.visited = set()
    
    def numIslands(self, grid):
        count = 0
        for r in range(len(grid)):
             for c in range(len(grid[r])):
                if grid[r][c] == '1' and (r,c) not in self.visited:
                    self.explore(grid, r, c)
                    count += 1
        return count
    
    def explore(self, grid, r, c):
        stack = [(r,c)]
        directions = [(0,1), (0,-1), (1,0), (-1,0)]
        while stack:
            currR, currC = stack.pop()
            if (currR,currC) not in self.visited:
                self.visited.add((currR, currC))
                for directionR, directionC in directions:
                    newR, newC = currR + directionR, currC + directionC
                    if newR >= 0 and newC >= 0 and newR < len(grid) and newC < len(grid[0]) and grid[newR][newC] == '1' and (newR,newC) not in self.visited:
                        stack.append((newR, newC))

if __name__ == '__main__':
    grid = [
  ["1","1","0","0","1"],
  ["1","1","0","0","0"],
  ["0","0","1","0","0"],
  ["0","0","0","1","1"]
]
islandObj = Island()
print(islandObj.numIslands(grid)) # 3
```

- Max and Min Islands
- Count by the stack and not the neighbours

```python
def numIslandsII(self, grid):
        maxCount = 0
        minCount = float('inf')
        for r in range(len(grid)):
            for c in range(len(grid[r])):
                if grid[r][c] == '1' and (r,c) not in self.visited:
                    count = self.exploreCount(grid, r, c)
                    maxCount = max(count, maxCount)
                    minCount = min(count, minCount)
        if minCount != float('inf'):
            return maxCount, minCount
        else:
            return maxCount, 0
    
    def exploreCount(self, grid, r, c):
        stack = [(r,c)]
        directions = [(0,1), (0,-1), (1,0), (-1,0)]
        count = 0
        while stack:
            currR, currC = stack.pop()
            if (currR,currC) not in self.visited:
                count += 1  # Increment count for each cell in the island
                self.visited.add((currR, currC))
                for directionR, directionC in directions:
                    newR, newC = currR + directionR, currC + directionC
                    if newR >= 0 and newC >= 0 and newR < len(grid) and newC < len(grid[0]) and grid[newR][newC] == '1' and (newR,newC) not in self.visited:
                        stack.append((newR, newC))
        return count
```

## A* Search Algorithm
- Is like Dijkstra's algorithm but with heuristic 
- heuristic will allow us to know whether we are going the right way and how far we have to go

#### Components

- **Graph Representation**: Similar to Dijkstra, the graph is a dictionary with nodes as keys and dictionaries of neighbors with edge weights as values.
- **Priority Queue**: A min-heap to explore nodes based on the combined cost of the actual distance from the start and the heuristic estimate to the goal.
- **Heuristic Function**: A function that estimates the cost to reach the goal from a given node.
- **Cost Tables**: Two dictionaries to track the actual cost to reach each node and the combined estimated cost.
#### Steps

1. **Initialization**:
    - Set the actual cost to reach the source node to 0 and all other nodes to infinity.
    - Calculate the heuristic cost for the source node and add it to the priority queue.
2. **Processing**:
    - While there are nodes in the priority queue, pop the node with the smallest combined cost.
    - If this node is the goal, reconstruct the path using the parent pointers.
    - For each neighbor, calculate the tentative cost to reach it and the combined estimated cost.
    - If the tentative cost is less than the known cost, update the cost tables and add the neighbor to the priority queue.
3. **Termination**:
    - The algorithm terminates when the goal node is reached and the path is reconstructed.


Manhattan distance is a heuristic used in grid-based pathfinding algorithms. It calculates the distance between two points in a grid based on a strictly horizontal and vertical path, rather than a diagonal path. Here's a detailed explanation:

### Manhattan Distance

The Manhattan distance between two points \((x_1, y_1)\) and \((x_2, y_2)\) in a grid is calculated as:
\[ \text{Manhattan distance} = |x_1 - x_2| + |y_1 - y_2| \]

This formula adds the absolute differences of their x-coordinates and y-coordinates. It effectively measures how many horizontal and vertical steps are required to get from one point to another.

### Why Use Manhattan Distance?

The Manhattan distance is used as a heuristic in pathfinding algorithms like A* because:
- It is easy to calculate.
- It provides an admissible heuristic (i.e., it never overestimates the actual distance) for grid-based maps where movement is restricted to horizontal and vertical steps.

### Heuristic Function in A* Algorithm

In the context of the A* algorithm, the heuristic function estimates the cost to reach the goal from a given node. Here's the heuristic function:

```python
def heuristic(a, b):
    return abs(a[0] - b[0]) + abs(a[1] - b[1])
```

This function takes two tuples `a` and `b`, which represent coordinates in the grid, and calculates the Manhattan distance between them.

### Example

Let's say we have a grid, and we want to find the distance from point (1, 2) to point (4, 6):

1. **Coordinates**:
   - Start point `a = (1, 2)`
   - Goal point `b = (4, 6)`

2. **Calculating Manhattan Distance**:
   - Difference in x-coordinates: \( |1 - 4| = 3 \)
   - Difference in y-coordinates: \( |2 - 6| = 4 \)
   - Manhattan distance: \( 3 + 4 = 7 \)

So, the Manhattan distance between (1, 2) and (4, 6) is 7.

### Visual Representation

Imagine a grid where you can only move horizontally or vertically:

```
(1,2) -> (2,2) -> (3,2) -> (4,2)
                         |
                         v
                       (4,3) -> (4,4) -> (4,5) -> (4,6)
```

This path consists of 3 horizontal steps and 4 vertical steps, totaling 7 steps, which matches our Manhattan distance calculation.

```python
import heapq

# Heuristic function: Manhattan distance for grid-based pathfinding
def heuristic(a, b):
    return abs(a[0] - b[0]) + abs(a[1] - b[1])

# A* Search Algorithm
def a_star_search(graph, start, goal):
    # Priority queue to store nodes to be explored, initialized with the start node
    open_set = []
    heapq.heappush(open_set, (0, start))
    
    # Dictionary to keep track of the path
    came_from = {}
    
    # Dictionary to keep the cost from the start to each node
    g_score = {start: 0}
    
    # Dictionary to keep the total estimated cost (g + h) for each node
    f_score = {start: heuristic(start, goal)}
    
    while open_set:
        # Pop the node with the smallest f_score
        _, current = heapq.heappop(open_set)
        
        # If the goal is reached, reconstruct the path
        if current == goal:
            return reconstruct_path(came_from, current), g_score[goal]
        
        # Explore the neighbors of the current node
        for neighbor in graph[current]:
            # Calculate the tentative g_score for the neighbor
            tentative_g_score = g_score[current] + graph[current][neighbor]
            
            # If the tentative g_score is better, update the path and scores
            if neighbor not in g_score or tentative_g_score < g_score[neighbor]:
                # Record the best path to the neighbor
                came_from[neighbor] = current
                
                # Update g_score for the neighbor
                g_score[neighbor] = tentative_g_score
                
                # Calculate f_score for the neighbor (g + heuristic)
                f_score[neighbor] = g_score[neighbor] + heuristic(neighbor, goal)
                
                # Add the neighbor to the open set with the updated f_score
                heapq.heappush(open_set, (f_score[neighbor], neighbor))
    
    # If the goal was never reached, return None and infinity cost
    return None, float('infinity')

# Function to reconstruct the path from the goal to the start using came_from dictionary
def reconstruct_path(came_from, current):
    total_path = [current]
    while current in came_from:
        current = came_from[current]
        total_path.append(current)
    # Return the path in the correct order from start to goal
    return total_path[::-1]

# Example usage:
graph = {
    'A': {'B': 1, 'C': 3},
    'B': {'A': 1, 'D': 1, 'E': 5},
    'C': {'A': 3, 'F': 2},
    'D': {'B': 1},
    'E': {'B': 5, 'F': 2},
    'F': {'C': 2, 'E': 2, 'G': 1},
    'G': {'F': 1}
}

start = 'A'
goal = 'G'
path, cost = a_star_search(graph, start, goal)
print("Path:", path)
print("Total cost:", cost)

```


Dijkstra
========

### Overview

Djikstra's algorithm is a graph-based technique for finding the globally shortest path between a starting node and a target node in a non-negative weighted Directed Acyclic Graph (DAG). It is a DAG in that edges are one way and there are no cycles in the graph; it is weighted in that each traversal of the graph has a certain cost. It is used often in graph-based applications such as social, network routing, and logistics supply modeling.

In its simplest form, the algorithm performs in O(v2) where |v| is the number of vertices in the graph.

Details of the algorithm may be found here:

* [Wikipedia](http://t.sidekickopen40.com/e1t/c/5/f18dQhb0S7lC8dDMPbW2n0x6l2B9nMJW7t5XZs5v0RzFW7d-0gY64kg9WVd0tpR56dVT-f3DKZz002?t=http%253A%252F%252Fen.wikipedia.org%252Fwiki%252FDijkstra's_algorithm&si=5907434065625088&pi=96db9355-bec5-40e9-cc69-c93d8b267768)
* [YouTube](http://t.sidekickopen40.com/e1t/c/5/f18dQhb0S7lC8dDMPbW2n0x6l2B9nMJW7t5XZs5v0RzFW7d-0gY64kg9WVd0tpR56dVT-f3DKZz002?t=http%253A%252F%252Fwww.youtube.com%252Fwatch%253Fv%253DgdmfOwyQlcI&si=5907434065625088&pi=96db9355-bec5-40e9-cc69-c93d8b267768)

### Challenge

Using the Ruby programming language, create a gem `djisktra` that constructs a graph and finds the shortest path between two user-supplied points.

The gem is a CLI application that accepts three arguments.

* The first argument is the name of the file that represents the graph
* The second argument is the name of the starting node
* The third argument is the name of the ending node

Example interaction includes:

```
$ gem install --local ./djikstra-1.0.0.gem
$ djikstra my_graph.txt A G
Shortest path is [A,B,E,G] with total cost 6
```

The graph file will consist of a set of edges. Each edge names a starting node, a destination node, and the weight:

```
[A,B,1]
[A,C,2]
[B,C,3]
[B,D,3]
[C,D,1]
[B,E,2]
[D,F,3]
[D,E,3]
[E,G,3]
[F,G,1]

```

This input would build an in-memory graph that is visually represented as follows:

![IMAGE](quiver-image-url/C612D547ECE39B217853EEFC1ABCE456.jpg =652x283)

Instructions
------------

1. Clone the gem
`git clone https://github.com/wzcolon/dijkstra.git`

2. Run it!
`cd dijkstra && bin/dijkstra my_graph.txt A G`

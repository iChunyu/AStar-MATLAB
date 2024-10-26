# A* Algorithm in MATLAB

Try the A* path-finding algorithm in MATLAB with the 2D map.

![](demo.png)

:warning: **This is an in-progress study project. Codes here may give a reasonable result, but I haven't fully checked.**

## Introduction

The `demo.m` shows a simple example of A* algorithm. You just create a `GridMap` with matrix of costs. Given the start and goal `Node` (matrix index), the `AStar` or `SimpleAStar` should be capable to find the costless path and show the result.

```MATLAB
clear;clc
close all

% Generate a map with random costs
map_data = randi([0 100], 10, 10);
map_data(map_data < 70) = 0;
map = GridMap(map_data);

% Set start and goal position (matrix index)
start = Node(1, 1);
goal = Node(10, 10);

% Call AStar to find the costless path
astar_solver = AStar(map, start, goal);
map.show('ShowPath', astar_solver.path)
fprintf('AStar total cost: %d\n', astar_solver.goal.cost)
```


## References

I started from the blog [Introduction to the A* Algorithm](https://www.redblobgames.com/pathfinding/a-star/introduction.html), which is very interesting with interactive visual explanations. But there are [some changes](https://www.redblobgames.com/pathfinding/a-star/implementation.html#algorithm) compared with the original version.

If you want to dive into the original algorithm, you may want to read the paper [A Formal Basis for the Heuristic Determination of Minimum Cost Paths](https://ieeexplore.ieee.org/abstract/document/4082128).

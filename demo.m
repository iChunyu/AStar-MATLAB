% A* demo

% XiaoCY, 2024-10-24

%%
clear;clc
close all

map_data = randi([0 50], 5, 5);
map = GridMap(map_data);

start = Node(1, 1);
goal = Node(5, 5);

[path, cost] = SimpleAStar(map, start, goal);
map.show('ShowPath', path, 'ShowValue', true)
fprintf('SimpAStar total cost: %d\n', cost)

astar_solver = AStar(map, start, goal);
map.show('ShowPath', astar_solver.path, 'ShowValue', true)
fprintf('AStar total cost: %d\n', astar_solver.goal.cost)
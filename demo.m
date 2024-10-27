% A* demo

% XiaoCY, 2024-10-24

%%
clear;clc
close all

map_data = randi([0 50], 5, 5);
map = GridMap(map_data);

start = Node(1, 1);
goal = Node(5, 5);

redblob_path = redblobAStar(map, start, goal);
map.show('ShowPath', redblob_path, 'ShowValue', true)
fprintf('SimpAStar total cost: %d\n', redblob_path(end, 3))

astar_path = AStar(map, start, goal);
map.show('ShowPath', astar_path, 'ShowValue', true)
fprintf('AStar total cost: %d\n', astar_path(end,3))
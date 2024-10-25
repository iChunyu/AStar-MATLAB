% A* demo

% XiaoCY, 2024-10-24

%%
clear;clc
close all

load('map_data.mat')
map = GridMap(map_data);

start = Node(6, 4);
goal = Node(1, 10);

path = SimpleAStar(map, start, goal);
map.show('ShowPath', path)

astar_solver = AStar(map, start, goal);
map.show('ShowPath', astar_solver.path)
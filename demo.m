% A* demo

% XiaoCY, 2024-10-24

%%
clear;clc
close all

load('map_data.mat')
map = GridMap(map_data);

start = Node(6, 4, 0, []);
goal = Node(1, 10);
path = AStarSolve(map, start, goal);
map.path = path;

map.show
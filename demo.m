% A* demo

% XiaoCY, 2024-10-24

%%
clear;clc
close all

load('map_data.mat')
map = GridMap(map_data);

start = [6, 4];
goal = [1 10];
path = AStarSolve(map, start, goal);
map.path = path;

map.show
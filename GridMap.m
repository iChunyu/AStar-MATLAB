% Grid map in graph form
% Ref: https://www.redblobgames.com/pathfinding/grids/graphs.html

% XiaoCY, 2024-10-23

%%
classdef GridMap < handle
    properties
        data = [];
        path = [];
        obstacle = inf;
    end

    methods
        % constructor
        function obj = GridMap(varargin)
            p = inputParser;
            p.addRequired('data');
            p.addOptional('obstacle', inf);
            p.addOptional('path', []);
            p.parse(varargin{:});

            obj.data = p.Results.data;
            obj.obstacle = p.Results.obstacle;
            obj.path = p.Results.path;
        end

        % return neighbors and cost
        function [index, cost] = neighbors(obj, loc)
            index = [];
            cost = [];
            [Ny, Nx] = size(obj.data);
            if loc(1) < 1 || loc(1) > Ny || loc(2) < 1 || loc(2) > Nx
                return
            end

            % up
            if loc(1) - 1 >= 1
                index = [index; loc(1)-1, loc(2)];
                cost = [cost; obj.data(loc(1)-1, loc(2))];
            end

            % left
            if loc(2) - 1 >= 1
                index = [index; loc(1), loc(2)-1];
                cost = [cost; obj.data(loc(1), loc(2)-1)];
            end

            % down
            if loc(1) + 1 <= Ny
                index = [index; loc(1)+1, loc(2)];
                cost = [cost; obj.data(loc(1)+1, loc(2))];
            end

            % right
            if loc(2) + 1 <= Nx
                index = [index; loc(1), loc(2)+1];
                cost = [cost; obj.data(loc(1), loc(2)+1)];
            end
        end

        % show map
        function show(obj, varargin)
            p = inputParser;
            p.addParameter('GridWidth', 0.5);
            p.addParameter('GridAlpha', 0.3);
            p.addParameter('CostAlpha', 0.7);
            p.addParameter('CostColor', [0.9804, 0.4980, 0.4353]);
            p.addParameter('ObstacleAlpha', 1);
            p.addParameter('ObstacleColor', [0.5098, 0.6902, 0.8235])
            p.addParameter('ShowPath', true);
            p.addParameter('PathWidth', 5);
            p.addParameter('PathColor', [0.5569, 0.8118, 0.7882]);
            p.addParameter('ShowValue', false);
            p.addParameter('FontSize', 20);
            p.parse(varargin{:});

            idx = obj.data < obj.obstacle;
            cmax = max(obj.data(idx));
            [Ny, Nx] = size(obj.data);
            xbase = [-0.5, 0.5, 0.5, -0.5];
            ybase = [-0.5, -0.5, 0.5, 0.5];

            figure
            patch([0.5, 0.5, Nx+0.5, Nx+0.5], [0.5, Ny+0.5, Ny+0.5, 0.5], [1, 1, 1], ...
                'LineWidth', p.Results.GridWidth, 'FaceAlpha', p.Results.GridAlpha);
            hold on
            for x = 1:Nx
                for y = 1:Ny
                    if obj.data(y, x) >= obj.obstacle
                        patch(x+xbase, y+ybase, p.Results.ObstacleColor, 'FaceAlpha', p.Results.ObstacleAlpha, ...
                            'EdgeAlpha', p.Results.GridAlpha, 'LineWidth', p.Results.GridWidth);
                    else
                        patch(x+xbase, y+ybase, p.Results.CostColor, 'FaceAlpha', obj.data(y, x)/cmax, ...
                            'EdgeAlpha', p.Results.GridAlpha, 'LineWidth', p.Results.GridWidth);
                        if p.Results.ShowValue
                            text(x, y, num2str(obj.data(y, x)), 'FontSize', p.Results.FontSize, ...
                                'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
                        end
                    end
                end
            end
            axis('off', 'equal', 'ij')

            if p.Results.ShowPath && ~isempty(obj.path)
                plot(obj.path(:,2), obj.path(:,1), 'Color', p.Results.PathColor, 'LineWidth', p.Results.PathWidth);
            end
        end
    end
end
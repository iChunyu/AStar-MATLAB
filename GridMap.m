% Grid map in graph form
% Ref: https://www.redblobgames.com/pathfinding/grids/graphs.html

% XiaoCY, 2024-10-23

%%
classdef GridMap < handle
    properties
        data = [];
        obstacle = inf;
    end

    methods
        % constructor
        function obj = GridMap(varargin)
            p = inputParser;
            p.addRequired('data');
            p.addOptional('obstacle', inf);
            p.parse(varargin{:});

            obj.data = p.Results.data;
            obj.obstacle = p.Results.obstacle;
        end

        % return neighbors and cost
        function neighbor_nodes = neighbors(obj, node)
            neighbor_nodes = [];
            [Ny, Nx] = size(obj.data);
            if node.row < 1 || node.row > Ny || node.col < 1 || node.col > Nx
                return
            end

            % up
            row = node.row - 1;
            col = node.col;
            if row >= 1 && obj.data(row, col) < obj.obstacle
                cost = node.cost + obj.data(row, col);
                neighbor_nodes = [neighbor_nodes; Node(row, col, cost, node)];
            end

            % left
            row = node.row;
            col = node.col-1;
            if col >= 1 && obj.data(row, col) < obj.obstacle
                cost = node.cost + obj.data(row, col);
                neighbor_nodes = [neighbor_nodes; Node(row, col, cost, node)];
            end

            % down
            row = node.row + 1;
            col = node.col;
            if row <= Ny && obj.data(row, col) < obj.obstacle
                cost = node.cost + obj.data(row, col);
                neighbor_nodes = [neighbor_nodes; Node(row, col, cost, node)];
            end

            % right
            row = node.row;
            col = node.col + 1;
            if col <= Nx && obj.data(row, col) < obj.obstacle
                cost = node.cost + obj.data(row, col);
                neighbor_nodes = [neighbor_nodes; Node(row, col, cost, node)];
            end
        end

        % show map
        function varargout = show(obj, varargin)
            p = inputParser;
            p.addParameter('GridWidth', 0.5);
            p.addParameter('GridAlpha', 0.3);
            p.addParameter('CostAlpha', 0.7);
            p.addParameter('CostColor', [0.9804, 0.4980, 0.4353]);
            p.addParameter('ObstacleColor', [0.7020, 0.7020, 0.7020])
            p.addParameter('ShowPath', []);
            p.addParameter('PathWidth', 5);
            p.addParameter('PathColor', [0.5569, 0.8118, 0.7882]);
            p.addParameter('ShowValue', false);
            p.addParameter('FontSize', 20);
            p.parse(varargin{:});

            idx = obj.data < obj.obstacle;
            cmax = max(obj.data(idx));
            if cmax == 0
                max_alpha = p.Results.CostAlpha;
            else
                max_alpha = p.Results.CostAlpha / cmax;
            end
            [Ny, Nx] = size(obj.data);
            xbase = [-0.5, 0.5, 0.5, -0.5];
            ybase = [-0.5, -0.5, 0.5, 0.5];
            go = gobjects(Ny, Nx);          % graphics objects

            if ~isempty(get(gcf, 'Children'))
                figure
            end
            patch([0.5, 0.5, Nx+0.5, Nx+0.5], [0.5, Ny+0.5, Ny+0.5, 0.5], [1, 1, 1], ...
                'LineWidth', p.Results.GridWidth, 'FaceAlpha', p.Results.GridAlpha);
            hold on
            for x = 1:Nx
                for y = 1:Ny
                    if obj.data(y, x) >= obj.obstacle
                        go(y, x) = patch(x+xbase, y+ybase, p.Results.ObstacleColor, 'LineWidth', p.Results.GridWidth);
                    else
                        go(y, x) = patch(x+xbase, y+ybase, p.Results.CostColor, 'FaceAlpha', obj.data(y, x) * max_alpha, ...
                            'EdgeAlpha', p.Results.GridAlpha, 'LineWidth', p.Results.GridWidth);
                        if p.Results.ShowValue
                            text(x, y, num2str(obj.data(y, x)), 'FontSize', p.Results.FontSize, ...
                                'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle');
                        end
                    end
                end
            end
            axis('off', 'equal', 'ij')

            if ~isempty(p.Results.ShowPath)
                plot(p.Results.ShowPath(:,2), p.Results.ShowPath(:,1), ...
                    'Color', p.Results.PathColor, 'LineWidth', p.Results.PathWidth);
            end

            if nargout > 0
                varargout{1} = go;
            end
        end
    end
end
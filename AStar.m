% AStar algorithm for path finding

% XiaoCY, 2024-10-26

%%
function astar_path = AStar(map, start, goal, varargin)
    p = inputParser;
    p.KeepUnmatched = true;
    p.addParameter('ShowProcess', false);
    p.addParameter('FrameRate', 0.1);
    p.addParameter('Filename', 'AStarProcess.gif');
    p.addParameter('CurrentColor', [1.0000, 0.7451, 0.4784]);
    p.addParameter('OpenColor', [0.3333, 0.6588, 0.4078])
    p.addParameter('ClosedColor', [0.2980, 0.4471, 0.6902]);
    p.addParameter('LineWidth', 2);
    p.addParameter('MarkerSize', 15);
    p.parse(varargin{:});
    plot_inited = false;

    % heuristic function handle
    heuristic = @(node) sqrt((goal.row - node.row)^2 + (goal.col - node.col)^2);

    % find path
    open = PriorityQueue;
    open.push(start, 0);
    closed = dictionary;        % use `containers.Map` for MATLAB version lower than R2020b
    while open.size > 0
        current = open.pop;
        closed(current.key) = current;

        if current == goal
            goal = current;     % refresh cost/parent infos
            break
        end

        neighbors = map.neighbors(current);
        for k = 1:length(neighbors)
            key = neighbors(k).key;
            priority = neighbors(k).cost + heuristic(neighbors(k));
            if isKey(closed, key)
                if neighbors(k).cost < closed(key).cost
                    closed(key) = [];
                    open.push(neighbors(k), priority)
                end
            else
                open.push(neighbors(k), priority)
            end
        end

        if p.Results.ShowProcess
            clf
            go = map.show(p.Unmatched);
            plot(start.col, start.row, 'color', p.Results.CurrentColor, 'Marker', 'o', 'MarkerSize', p.Results.MarkerSize)
            plot(goal.col, goal.row, 'color', p.Results.CurrentColor, 'Marker', 'pentagram', 'MarkerSize', p.Results.MarkerSize)
            keys = closed.keys;
            for k = 1:length(keys)
                row = closed(keys(k)).row;
                col = closed(keys(k)).col;
                go(row, col).FaceColor = p.Results.ClosedColor;
                go(row, col).EdgeColor = p.Results.ClosedColor;
                go(row, col).EdgeAlpha = 1;
                go(row, col).LineWidth = p.Results.LineWidth;
            end
            for k = 1:open.size
                row = open.data{k, 1}.row;
                col = open.data{k, 1}.col;
                go(row, col).FaceColor = p.Results.OpenColor;
                go(row, col).EdgeColor = p.Results.OpenColor;
                go(row, col).EdgeAlpha = 1;
                go(row, col).LineWidth = p.Results.LineWidth;
            end
            row = current.row;
            col = current.col;
            go(row, col).FaceColor = p.Results.CurrentColor;
            go(row, col).EdgeColor = p.Results.CurrentColor;
            go(row, col).EdgeAlpha = 1;
            go(row, col).LineWidth = p.Results.LineWidth;
            pause(p.Results.FrameRate)

            frame = getframe(gcf);
            im = frame2im(frame);
            [imind, cm] = rgb2ind(im, 256);
            if ~plot_inited
                plot_inited = true;
                imwrite(imind, cm, p.Results.Filename, 'gif', 'Loopcount', inf);
            else
                imwrite(imind, cm, p.Results.Filename, 'gif', 'WriteMode', 'append', 'DelayTime', p.Results.FrameRate);
            end
        end
    end

    % generate path: [row, col, cost]
    node = goal;
    astar_path = zeros(goal.depth, 3);
    for k = 1:goal.depth
        astar_path(k, :) = [node.row, node.col, node.cost];
        node = node.parent;
    end
    astar_path = astar_path(end:-1:1, :);

    if p.Results.ShowProcess
        clf
        map.show('ShowPath', astar_path, p.Unmatched);
        plot(start.col, start.row, 'color', p.Results.CurrentColor, 'Marker', 'o', 'MarkerSize', p.Results.MarkerSize)
        plot(goal.col, goal.row, 'color', p.Results.CurrentColor, 'Marker', 'pentagram', 'MarkerSize', p.Results.MarkerSize)
        frame = getframe(gcf);
        im = frame2im(frame);
        [imind, cm] = rgb2ind(im, 256);
        imwrite(imind, cm, p.Results.Filename, 'gif', 'WriteMode', 'append', 'DelayTime', 1);
    end
end
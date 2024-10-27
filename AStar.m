% AStar algorithm for path finding

% XiaoCY, 2024-10-26

%%
function astar_path = AStar(map, start, goal)
    % heuristic function handle
    heuristic = @(node) abs(goal.row - node.row) + abs(goal.col - node.col);

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
    end

    % generate path: [row, col, cost]
    node = goal;
    astar_path = zeros(goal.depth, 3);
    for k = 1:goal.depth
        astar_path(k, :) = [node.row, node.col, node.cost];
        node = node.parent;
    end
    astar_path = astar_path(end:-1:1, :);
end
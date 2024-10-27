% AStar algorithm for path finding

% XiaoCY, 2024-10-26

%%
function astar_path = AStar(map, start, goal)
    % heuristic function handle
    heuristic = @(node) abs(goal.row - node.row) + abs(goal.col - node.col);

    % find path
    open = PriorityQueue;
    open.push(start, 0);
    closed = [];
    while open.size > 0
        current = open.pop;
        closed = [closed; current];

        if current == goal
            % break loop and record data
            obj.goal = current;
            obj.closed = closed;
            break
        end

        neighbors = map.neighbors(current);
        for k = 1:length(neighbors)
            idx = 0;
            for n = 1:length(closed)
                if neighbors(k) == closed(n)
                    idx = n;
                    break;
                end
            end
            priority = neighbors(k).cost + heuristic(current);
            if idx > 0
                if neighbors(k).cost < closed(idx).cost
                    closed(idx) = [];
                    open.push(neighbors(k), priority)
                end
            else
                open.push(neighbors(k), priority)
            end
        end
    end

    % generate path: [row, col, cost]
    node = obj.goal;
    astar_path = [node.row, node.col, node.cost];
    while ~isempty(node.parent)
        node = node.parent;
        astar_path = [astar_path; node.row, node.col, node.cost];
    end
    astar_path = astar_path(end:-1:1, :);
end
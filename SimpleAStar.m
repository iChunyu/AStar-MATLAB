% A* algorithm to find costless path
% Ref: https://www.redblobgames.com/pathfinding/a-star/introduction.html

% XiaoCY, 2024-10-24

%%
function varargout = SimpleAStar(map, start, goal)
    frontier = PriorityQueue;
    came_from = cell(size(map.data));       % {[row, col], cost_so_far} in each cell
    came_from{start.row, start.col} = {[], 0};

    frontier.push(start, 0);
    heuristic = @(node) abs(goal.row - node.row) + abs(goal.col - node.col);

    while frontier.size > 0
        current = frontier.pop();

        if current == goal
            break
        end

        neighbors = map.neighbors(current);
        for k = 1:length(neighbors)
            if isempty(came_from{neighbors(k).row, neighbors(k).col}) ...
                    || neighbors(k).cost < came_from{neighbors(k).row, neighbors(k).col}{2}
                came_from{neighbors(k).row, neighbors(k).col} = {[current.row, current.col], neighbors(k).cost};
                priority = neighbors(k).cost + heuristic(current);
                frontier.push(neighbors(k), priority);
            end
        end
    end

    path = [goal.row, goal.col];
    index = came_from{goal.row, goal.col}{1};
    while ~isempty(index)
        path = vertcat(path, index);
        index = came_from{index(1), index(2)}{1};
    end

    varargout{1} = path;
    varargout{2} = came_from{goal.row, goal.col}{2};
end

% A* algorithm to find costless path
% Ref: https://www.redblobgames.com/pathfinding/a-star/introduction.html

% XiaoCY, 2024-10-24

%%
function path = AStarSolve(map, start, goal)
    frontier = PriorityQueue;
    came_from = cell(size(map.data));       % {[row, col], cost_so_far} in each cell
    came_from{start(1), start(2)} = {[], 0};

    frontier.push(start, 0);
    heuristic = @(start, goal) sum(abs(goal - start));

    while frontier.size > 0
        current = frontier.pop();

        if isequal(current, goal)
            break
        end

        [neighbors, costs] = map.neighbors(current);
        for k = 1:length(neighbors)
            new_cost = came_from{current(1), current(2)}{2} + costs(k) + 1;
            if isempty(came_from{neighbors(k, 1), neighbors(k, 2)}) ...
                    || new_cost < came_from{neighbors(k, 1), neighbors(k, 2)}{2}
                came_from{neighbors(k, 1), neighbors(k, 2)} = {current, new_cost};
                priority = new_cost + heuristic(current, goal);
                frontier.push(neighbors(k, :), priority);
            end
        end
    end

    path = goal;
    index = came_from{goal(1), goal(2)}{1};
    while ~isempty(index)
        path = vertcat(path, index);
        index = came_from{index(1), index(2)}{1};
    end
end

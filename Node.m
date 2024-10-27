% Map node class(struct) inherited from `handle` to save memory

% XiaoCY, 2024-10-25

%%
classdef Node < handle
    properties
        row             % row index
        col             % column index
        cost            % cost so far
        parent          % parent Node
        depth           % steps from start to current node
    end

    methods
        function obj = Node(varargin)
            p = inputParser;
            p.addRequired('row');
            p.addRequired('col');
            p.addOptional('cost', 0);
            p.addOptional('parent', [], @(n) isa(n, 'Node'));
            p.addOptional('depth', []);
            p.parse(varargin{:});

            obj.row = p.Results.row;
            obj.col = p.Results.col;
            obj.cost = p.Results.cost;
            obj.parent = p.Results.parent;
            if isempty(p.Results.parent)
                obj.depth = 1;
            else
                obj.depth = p.Results.parent.depth + 1;
            end
        end

        % override `==` operator, only check row and column index
        function is_equal = eq(obj1, obj2)
            if isa(obj2, 'Node')
                is_equal = obj1.row == obj2.row && obj1.col == obj2.col;
            else
                is_equal = false;
            end
        end

        % fake hash key
        % Hint: MATLAB built-in `dictionary` and `containers.Map` are hash tables, 
        %   but users only need to give a unique 'key'. Here I chose the matrix index.
        function val = key(obj)
            val = sprintf('(%d, %d)', obj.row, obj.col);
        end
    end
end
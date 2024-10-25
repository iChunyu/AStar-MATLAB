% Map node class(struct) inherited from `handle` to save memory

% XiaoCY, 2024-10-25

%%
classdef Node < handle
    properties
        row             % row index
        col             % column index
        cost            % cost so far
        parent          % parent Node
    end

    methods
        function obj = Node(varargin)
            p = inputParser;
            p.addRequired('row');
            p.addRequired('col');
            p.addOptional('cost', 0);
            p.addOptional('parent', [], @(n) isa(n, 'Node'));
            p.parse(varargin{:});

            obj.row = p.Results.row;
            obj.col = p.Results.col;
            obj.cost = p.Results.cost;
            obj.parent = p.Results.parent;
        end

        % override `==` operator, only check row and column index
        function is_equal = eq(obj1, obj2)
            if isa(obj2, 'Node')
                is_equal = obj1.row == obj2.row && obj1.col == obj2.col;
            else
                is_equal = false;
            end
        end
    end
end
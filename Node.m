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
            p.addOptional('cost', inf);
            p.addOptional('parent', []);
            p.parse(varargin{:});

            obj.row = p.Results.row;
            obj.col = p.Results.col;
            obj.cost = p.Results.cost;
            obj.parent = p.Results.parent;
        end
    end
end
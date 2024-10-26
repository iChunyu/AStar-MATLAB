% Priority queue realized by heap
% Ref: https://algo.itcharge.cn/01.Array/02.Array-Sort/07.Array-Heap-Sort/

% XiaoCY, 2024-10-22

%%
classdef PriorityQueue < handle
    properties
        % data = {{data1}, {priority1}; {data2}, {priority2}; ...}
        %   where, priority1 < prority2 < ...
        data = {};
        size = 0;
    end

    methods
        % constructor
        function obj = PriorityQueue(data)
            if nargin == 1
                for k = 1:size(data, 1)
                    obj.push(data{k, 1}, data{k, 2});
                end
            end
        end

        % add data to heap
        function push(obj, value, priority)
            % check duplication
            for k = 1:obj.size
                if value == obj.data{k, 1}
                    if priority < obj.data{k, 2}
                        obj.data(k, :) = {value, priority};
                        obj.shift_up(k);
                    end
                    return
                end
            end
            obj.size = obj.size + 1;
            obj.data = [obj.data; {value}, priority];
            obj.shift_up(obj.size);
        end

        % get and remove data from heap
        function varargout = pop(obj)
            if obj.size == 0
                varargout = {[], []};
                return
            end
            varargout = obj.data(1, :);
            obj.data(1, :) = obj.data(end, :);
            obj.data(end, :) = [];
            obj.size = obj.size - 1;
            obj.shift_down(1);
        end

        % clear all data
        function clear(obj)
            obj.data = {};
            obj.size = 0;
        end
    end

    methods (Access = private)
        function shift_up(obj, index)
            upper = get_upper(index);
            while upper > 0 && obj.data{index, 2} < obj.data{upper, 2}
                tmp = obj.data(index, :);
                obj.data(index, :) = obj.data(upper, :);
                obj.data(upper, :) = tmp;
                index = upper;
                upper = get_upper(index);
            end
        end

        function shift_down(obj, index)
            left = get_left(index);
            right = get_right(index);
            while left <= obj.size
                if right > obj.size
                    prior = left;
                else
                    if obj.data{left, 2} < obj.data{right, 2}
                        prior = left;
                    else
                        prior = right;
                    end
                end
                
                if obj.data{index, 2} > obj.data{prior, 2}
                    tmp_data = obj.data(index, :);
                    obj.data(index, :) = obj.data(prior, :);
                    obj.data(prior, :) = tmp_data;
                    index = prior;
                    left = get_left(index);
                    right = get_right(index);
                else
                    break
                end
            end
        end
    end
end

%% Heap data index
function idx = get_upper(index)
    idx = floor(index/2);
end

function idx = get_left(index)
    idx = 2 * index;
end

function idx = get_right(index)
    idx = 2 * index + 1;
end
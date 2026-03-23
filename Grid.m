classdef Grid < handle
    %GRID Summary of this class goes here
    %   Detailed explanation goes here

    properties
        width;
        state; % State of the board starting at top left, -1 is null, 0 is O, 1 is X
        x;
        y;
        cellwidth;
        parent; % TicTacToe object that owns this grid
    end

    methods
        function obj = Grid(x, y, width, parent)
            obj.x = x;
            obj.y = y;
            obj.state = [-1 -1 -1 -1 -1 -1 -1 -1 -1];
            obj.width = width;
            obj.cellwidth = width/3;
            obj.parent = parent;
            drawGrid(obj)
        end
        
        function drawGrid(obj)
            disp(obj.parent)
            for i = 1:2
                obj.parent.DrawLine((obj.x + obj.cellwidth*i), obj.y, (obj.x + obj.cellwidth*i), (obj.y - obj.width)); % draw vertical lines
                obj.parent.DrawLine(obj.x, (obj.y - obj.cellwidth*i), (obj.x + obj.width), (obj.y - obj.cellwidth*i));
            end
        end

        function center = getCenter(obj, index) % find center of cell based on index
            i = index - 1;
            row = floor(i/3) + 1;
            col = floor(mod(i,3)) + 1;

            xc = obj.x + col*obj.cellwidth - obj.cellwidth/2;
            yc = obj.y - row*obj.cellwidth + obj.cellwidth/2;

            center = [xc yc];
        end

        function addX(obj, index) % add an X to the board at a specified index 1-9       
            disp(obj.state(index))
            if obj.state(index) ~= -1
                % If something is already in this cell, do nothing
                disp("Spot already marked!")
                return
            end

            obj.state(index) = 1;
            
            c = obj.getCenter(index);
            obj.parent.DrawX(c(1), c(2), obj.cellwidth-1)
        end

        function addO(obj, index) % add an O to the board at a specified index 1-9       
            if obj.state(index) ~= -1
                % If something is already in this cell, do nothing
                disp("Spot already marked!")
                return
            end

            obj.state(index) = 0;
            
            c = obj.getCenter(index);
            obj.parent.DrawCircle(c(1), c(2), (obj.cellwidth-1)/2)
        end

        function resetGrid(obj)
            obj.state = [-1 -1 -1 -1 -1 -1 -1 -1 -1];
        end

        function isfull = IsFull(obj)
            if ~ismember(-1, obj.state)
                isfull = true;
            else
                isfull = false;
            end
        end
    end
end
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
            obj.state = [0 0 0 0 0 0 0 0 0];%0 is empty space
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
            if obj.state(index) ~= 0
                % If something is already in this cell, do nothing
                disp("Spot already marked!")
                return
            end

            obj.state(index) = 2;
            
            c = obj.getCenter(index);
            obj.parent.DrawX(c(1), c(2), obj.cellwidth-1)
        end

        function addO(obj, index) % add an O to the board at a specified index 1-9       
            if obj.state(index) ~= 0
                % If something is already in this cell, do nothing
                disp("Spot already marked!")
                return
            end

            obj.state(index) = 3;
            
            c = obj.getCenter(index);
            obj.parent.DrawCircle(c(1), c(2), (obj.cellwidth-1)/2)
        end

        function resetGrid(obj)
            obj.state = [0 0 0 0 0 0 0 0 0];
        end

        function isfull = IsFull(obj)
            if ~ismember(0, obj.state)
                isfull = true;
            else
                isfull = false;
            end
        end

        function isWinner(obj)
            %Row sums to check for wins
            WinRow1 = obj.state(1) + obj.state(2) + obj.state(3);
            WinRow2 = obj.state(4) + obj.state(5) + obj.state(6);
            WinRow3 = obj.state(7) + obj.state(8) + obj.state(9);

            %column sums ito check for wins
            WinCol1 = obj.state(1) + obj.state(2) + obj.state(3);
            WinCol2 = obj.state(4) + obj.state(5) + obj.state(6);
            WinCol3 = obj.state(7) + obj.state(8) + obj.state(9);

            %diagonal sums to check for wins
            WinDiag1 = obj.state(1) + obj.state(5) + obj.state(9);
            WinDiag2 = obj.state(3) + obj.state(5) + obj.state(7);

            if (WinRow1 == 6) || (WinRow2== 6) || (WinRow3 == 6) || (WinCol1 == 6)|| (WinCol2 == 6)|| (WinCol3== 6) || (WinDiag1== 6) || (WinDiag2== 6)
                disp('X wins the game!');
            elseif (WinRow1 == 9) || (WinRow2== 9) || (WinRow3 == 9) || (WinCol1 == 9)|| (WinCol2 == 9)|| (WinCol3== 9) || (WinDiag1== 9) || (WinDiag2== 9)
                disp('O wins the game!');
            else
                disp('No winner yet.')
            end
        end
    end
end
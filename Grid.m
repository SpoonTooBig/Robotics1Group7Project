classdef Grid < handle
    %GRID Summary of this class goes here
    %   Detailed explanation goes here

    properties
        width;
        state; % State of the board starting at top left, N is null
        x;
        y;
        cellwidth;
        parent; % TicTacToe object that owns this grid
    end

    methods
        function obj = Grid(x, y, width, parent)
            obj.x = x;
            obj.y = y;
            obj.state = ['N' 'N' 'N' 'N' 'N' 'N' 'N' 'N' 'N'];%0 is empty space
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
            if obj.state(index) ~= 'N'
                % If something is already in this cell, do nothing
                disp("Spot already marked!")
                return
            end

            obj.state(index) = 'X';
            
            c = obj.getCenter(index);
            obj.parent.DrawX(c(1), c(2), obj.cellwidth-1)
        end

        function addO(obj, index) % add an O to the board at a specified index 1-9       
            if obj.state(index) ~= 'N'
                % If something is already in this cell, do nothing
                disp("Spot already marked!")
                return
            end

            obj.state(index) = 'O';
            
            c = obj.getCenter(index);
            obj.parent.DrawCircle(c(1), c(2), (obj.cellwidth-1)/2)
        end

        function resetGrid(obj)
            obj.state = ['N' 'N' 'N' 'N' 'N' 'N' 'N' 'N' 'N'];
        end

        function isfull = IsFull(obj)
            if ~ismember('N', obj.state)
                isfull = true;
            else
                isfull = false;
            end
        end

        function winner = isWinner(obj)
            winner = '';
            %Row sums to check for wins             
            WinRow1 = strcat(obj.state(1), obj.state(2), obj.state(3));             
            WinRow2 = strcat(obj.state(4), obj.state(5), obj.state(6));             
            WinRow3 = strcat(obj.state(7), obj.state(8), obj.state(9));              
            
            %column sums to check for wins             
            WinCol1 = strcat(obj.state(1), obj.state(4), obj.state(7));             
            WinCol2 = strcat(obj.state(2), obj.state(5), obj.state(8));             
            WinCol3 = strcat(obj.state(3), obj.state(6), obj.state(9));              
            
            %diagonal sums to check for wins             
            WinDiag1 = strcat(obj.state(1), obj.state(5), obj.state(9));             
            WinDiag2 = strcat(obj.state(3), obj.state(5), obj.state(7));

            if (WinRow1 == "XXX") | (WinRow2== "XXX") | (WinRow3 == "XXX") | (WinCol1 == "XXX")| (WinCol2 == "XXX")| (WinCol3== "XXX") | (WinDiag1== "XXX") | (WinDiag2== "XXX")
                winner = 'X'; % X wins
            elseif (WinRow1 == "OOO") | (WinRow2== "OOO") | (WinRow3 == "OOO") | (WinCol1 == "OOO")| (WinCol2 == "OOO")| (WinCol3== "OOO") | (WinDiag1== "OOO") | (WinDiag2== "OOO")
                winner = 'O'; % O wins
            end
        end
    end
end
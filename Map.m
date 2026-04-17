classdef Map < handle
    %GRID Summary of this class goes here
    %   Detailed explanation goes here

    properties
        width;
        height;
        state; % State of the board starting at top left, N is null
        x;
        y;
        parent; % TicTacToe object used by this map
        map;
    end

    methods
        function obj = Map(x, y, width, height, parent)
            obj.x = x;
            obj.y = y;
            obj.width = width;
            obj.height = height;
            obj.parent = parent;
            obj.map = obj.MakeMap();
        end

        function map = MakeMap(obj)
            map = zeros(100,100);
            
            map(84:90,8:40) = 1;%left eyebrow
            obj.drawBox(8,40,84,90);

            map(84:90,60:92) = 1;%right eyebrow
            obj.drawBox(60,92,84,90);
            
            map(66:78,22:36) = 1;%left eye
            obj.drawBox(22,36,66,78);
            
            map(66:78,64:78) = 1;%right eye
            obj.drawBox(64,78,66,78);
            
            map(40:46,40:60) = 1;%nose
            obj.drawBox(40,60,40,46);
            
            map(24:50,10:16) = 1;%left smile 
            obj.drawBox(10,16,24,50);
            
            map(24:50,84:90) = 1;%right smile 
            obj.drawBox(84,90,24,50);
            
            map(10:24,10:90) = 1;%bottom smile
            obj.drawBox(10,90,10,24);
        end
        
        function drawBox(obj, x0, x1, y0, y1) % example for range : [84 90 8 40] y0 y1 x0 x1
            p1 = obj.MapToLocation([x0 y0]);
            p2 = obj.MapToLocation([x0 y1]);
            obj.parent.DrawLine(p1(1), p1(2), p2 (1), p2(2));
            p1 = obj.MapToLocation([x0 y1]);
            p2 = obj.MapToLocation([x1 y1]);
            obj.parent.DrawLine(p1(1), p1(2), p2 (1), p2(2));
            p1 = obj.MapToLocation([x1 y1]);
            p2 = obj.MapToLocation([x1 y0]);
            obj.parent.DrawLine(p1(1), p1(2), p2 (1), p2(2));
            p1 = obj.MapToLocation([x1 y0]);
            p2 = obj.MapToLocation([x0 y0]);
            obj.parent.DrawLine(p1(1), p1(2), p2 (1), p2(2));
        end

        function loc = MapToLocation(obj, point)
            loc_x = rescale(point(1), obj.x, obj.x + obj.width,'InputMin', 1, 'InputMax', 100);
            loc_y = rescale(point(2), obj.y, obj.y + obj.height,'InputMin', 1, 'InputMax', 100);

            loc = [loc_x loc_y];
        end

        function NavigateMap(obj, goal, start)
            dx = DXform(obj.map);
            dx.plan(goal);
            p = dx.query(start);

            for i = 2:length(p)
                p1 = MapToLocation(obj, p(i-1, :));
                p2 = MapToLocation(obj, p(i, :));
                obj.parent.DrawLine(p1(1), p1(2), p2 (1), p2(2));
            end
        end
    end
end
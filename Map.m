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
            map(84:90,60:92) = 1;%right eyebrow
            map(66:78,22:36) = 1;%left eye
            map(66:78,64:78) = 1;%right eye
            map(40:46,40:60) = 1;%nose
            map(24:50,10:16) = 1;%left smile 
            map(24:50,84:90) = 1;%right smile 
            map(10:24,10:90) = 1;%bottom smile 
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

            for i = 2:length(p):
                p1 = MapToLocation(P(i-1));
                p2 = MapToLocation(P(i));
                parent.DrawLine(p1(1), p1(2), p2 (1), p2(2))
        end
    end
end
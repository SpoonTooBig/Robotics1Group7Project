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
            
            obj.parent.RaisePen();
            map(84:90,8:40) = 1;%left eyebrow
            obj.drawBox(8,40,84,90);
            obj.parent.RaisePen();

            map(84:90,60:92) = 1;%right eyebrow
            obj.drawBox(60,92,84,90);
            obj.parent.RaisePen();

            map(66:78,22:36) = 1;%left eye
            obj.drawBox(22,36,66,78);
            obj.parent.RaisePen();

            map(66:78,64:78) = 1;%right eye
            obj.drawBox(64,78,66,78);
            obj.parent.RaisePen();

            map(40:46,40:60) = 1;%nose
            obj.drawBox(40,60,40,46);
            obj.parent.RaisePen();

            map(24:50,10:16) = 1;%left smile 
            obj.drawBox(10,16,24,50);
            obj.parent.RaisePen();

            map(24:50,84:90) = 1;%right smile 
            obj.drawBox(84,90,24,50);
            obj.parent.RaisePen();

            map(10:24,10:90) = 1;%bottom smile
            obj.drawBox(10,90,10,24);
            obj.parent.RaisePen();
            
        end
        
        
        function drawBox(obj, x0, x1, y0, y1) % example for range : [84 90 8 40] y0 y1 x0 x1
            tic;
            p1 = obj.MapToLocation([x0 y0]);
            p2 = obj.MapToLocation([x1 y1]);
            obj.parent.drawBox(p1(1), p1(2), p2(1), p2(2))
            Ts1 = toc;
            fprintf(' Time is to draw the maze is: %4f seconds\n' , Ts1)
            
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
            
            %%Pathlength
            dx_v = diff(p(:,1));
            dy_v = diff(p(:,2));
            segmentLengths = sqrt(dx_v.^2 + dy_v.^2);
            pathLength = sum(segmentLengths);
            %%Smoothness
            smoothness = 0;

            for i = 2:size(p,1)-1
                v1 = p(i,:) - p(i-1,:);
                v2 = p(i+1,:) - p(i,:);

                if norm(v1)==0 || norm(v2)==0
                    continue;
                end

                cosTheta = dot(v1,v2)/(norm(v1)*norm(v2));
                cosTheta = max(min(cosTheta,1),-1); 

                theta = acos(cosTheta);
                smoothness = smoothness + abs(theta);
            end

            %%Draw Path
            tic;
            for i = 2:length(p)
                p1 = MapToLocation(obj, p(i-1, :));
                p2 = MapToLocation(obj, p(i, :));
                obj.parent.DrawLine(p1(1), p1(2), p2 (1), p2(2), true);
            end
            obj.parent.raisePen()
            Ts2 = toc;
            TotalTime = Ts1 + Ts2;
            fprintf('Time to draw the path is: %4f seconds\n' , Ts2);
            fprintf('Path Length: %.2f\n', pathLength);
            fprintf('Smoothness: %.2f radians\n', smoothness);
            
            figure;
            scatter3(TotalTime, pathLengths, smoothness, 120, 'filled');
            xlabel('Time');
            ylabel('Path Length');
            zlabel('Smoothness');
            title('Run-to-Run Comparison');
            grid on;
            
        end
    end
end
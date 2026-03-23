classdef TicTacToe < handle
    %TICTACTOE Summary of this class goes here
    %   Detailed explanation goes here

    properties
        robot = DrawBot;
        ar;
        servo1;
        servo2;
        penServo;
    end

    methods
        function obj = TicTacToe()
            %TICTACTOE Construct an instance of this class
            %   Detailed explanation goes here
            comPorts = serialportlist("available");
            if ~isempty(comPorts)
                obj.ar = arduino(comPorts(1), 'Uno');
                obj.servo1 = servo(obj.ar, 'D5');
                obj.servo2 = servo(obj.ar, 'D6');
                obj.penServo = servo(obj.ar, 'D7');
            else
                disp("ARDUINO NOT FOUND, EXITING")
                exit
            end
        end
        
        function DrawX(obj, xc, yc, width)
            offset = width/2;
            DrawLine(obj, xc-offset, yc+offset, xc+offset, yc-offset)
            DrawLine(obj, xc+offset, yc+offset, xc-offset, yc-offset)
        end

        function DrawCircle(obj, xc, yc, r)
            
            x0 = xc + r;
            y0 = yc;
            % Move to starting point of the circle
            obj.MoveTo(x0, y0);
            pause(1);

            obj.LowerPen();

            % Angle step currently 0.1cm step size
            %th is theta
            for th = 0:0.1:2*pi
        
                 x = xc + r*cos(th);
                 y = yc + r*sin(th);
                 disp([x, y])
                 obj.MoveTo(x, y);
        
            end

            obj.RaisePen();

        end
        
        function DrawLine(obj, x1, y1, x2, y2)
            obj.RaisePen()
            % MoveTo x1,y1
            obj.MoveTo(x1, y1)
            pause(.5);
            obj.LowerPen()
            pause(.5);

            % Use y=mx+b to generate function along the desired line
            m = (y2-y1)/(x2-x1);
            b = y1 - m*x1;

            if isinf(m)
                % vertical line case
                if y2 > y1                    
                    for y = y1:0.2:y2
                        disp([x1, y])
                        obj.MoveTo(x1, y);
                    end
                else 
                    for y = y1:-0.2:y2
                        disp([x1, y])
                        obj.MoveTo(x1, y);
                    end
                end
                obj.RaisePen();
                return
            end

            % Iterate through line at an step size of .2 cm
            
            if x2 > x1
                for x = x1:0.2:x2
                    y = m*x + b;
                    disp([x, y])
                    obj.MoveTo(x, y);
                end
            else
                for x = x1:-0.2:x2
                    y = m*x + b;
                    disp([x, y])
                    obj.MoveTo(x, y);
                end
            end
            obj.RaisePen();
        end
        
        function MoveTo(obj, x, y)
            angles = obj.robot.ikine(transl(x, y, 0),'mask', [1 1 0 0 0 0]);
            
            sAngle1 = 1.0 - rescale(angles(1), 0.0, 1.0, 'InputMin', -25*(pi/180), 'InputMax', 165*(pi/180));
            sAngle2 = 1.0 - rescale(angles(2), 0.0, 1.0, 'InputMin', -160*(pi/180), 'InputMax', 60*(pi/180));


            writePosition(obj.servo1, sAngle1);
            writePosition(obj.servo2, sAngle2);

        end

        function RaisePen(obj)
            writePosition(obj.penServo, 0.7)
        end

        function LowerPen(obj)
            writePosition(obj.penServo, 0.2)
        end
    end
end
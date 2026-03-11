classdef TicTacToe
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
                obj.servo1 = servo(obj.ar, 'D9');
                obj.servo2 = servo(obj.ar, 'D10');
                obj.penServo = servo(obj.ar, 'D11');
            else
                disp("ARDUINO NOT FOUND, EXITING")
                exit
            end
        end

        function DrawLine(obj, x1, y1, x2, y2)
            % MoveTo x1,y1
            obj.MoveTo(obj, x1, y1)
            % Use y=mx+b to generate function along the desired line
            m = (y2-y1)/(x2-x1);
            b = m*x1 - y1;
            % Iterate through line at an step size of .2 cm
            for x = x1:0.2:x2
                y = m*x + b;
                MoveTo(x, y);
            end
        end
        
        function MoveTo(obj, x, y)

            angles = obj.robot.ikine(transl(x, y, 0),'mask', [1 1 0 0 0 0]);
            
            sAngle1 = rescale(angles(1), 0.0, 1.0, 'InputMin', -25*(pi/180), 'InputMax', 165*(pi/180));
            sAngle2 = rescale(angles(2), 0.0, 1.0, 'InputMin', -160*(pi/180), 'InputMax', 60*(pi/180));

            writePosition(obj.servo1, sAngle1)
            writePosition(obj.servo2, sAngle2)

        end

        function RaisePen(obj)
            writePosition(obj.penServo, 0.0)
        end

        function LowerPen(obj)
            writePosition(obj.penServo, 1.0)
        end
    end
end
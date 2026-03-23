classdef DrawBot < SerialLink
    properties  
    qz
    end
    methods
        function obj = DrawBot()
            deg = pi/180;
            L(1) = Revolute('d', 2.026, ...   % link length (Dennavit-Hartenberg notation)
            'a', 10.062, ...               % link offset (Dennavit-Hartenberg notation)
            'alpha', 0, ...        % link twist (Dennavit-Hartenberg notation)
            'offset', -0.002, ...
            'qlim', [-160 160]*deg ); % minimum and maximum joint angle
        
            L(2) = Revolute('d', 2.081, ...   % link length (Dennavit-Hartenberg notation)
            'a', 8.118, ...               % link offset (Dennavit-Hartenberg notation)
            'alpha', 0, ...        % link twist (Dennavit-Hartenberg notation)
            'offset', 1.776, ...
            'qlim', [-160 160]*deg ); % minimum and maximum joint angle

            obj@SerialLink(L, 'name', 'DrawBot');
            obj.base = transl(12.2, 1.8, 7.8);
            obj.qz = zeros(length(L));

        end
    end
end
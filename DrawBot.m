classdef DrawBot < SerialLink
    properties  
    qz
    end
    methods
        function obj = DrawBot()
            deg = pi/180;
            L(1) = Revolute('d', 0, ...   % link length (Dennavit-Hartenberg notation)
            'a', 10.5, ...               % link offset (Dennavit-Hartenberg notation)
            'alpha', 0, ...        % link twist (Dennavit-Hartenberg notation)
            'offset', .0038*deg, ...
            'qlim', [-160 160]*deg ); % minimum and maximum joint angle
        
            L(2) = Revolute('d', 0, ...   % link length (Dennavit-Hartenberg notation)
            'a', 8.8, ...               % link offset (Dennavit-Hartenberg notation)
            'alpha', 0, ...        % link twist (Dennavit-Hartenberg notation)
            'offset', .0038*deg, ...
            'qlim', [-160 160]*deg ); % minimum and maximum joint angle

            obj@SerialLink(L, 'name', 'DrawBot');
            obj.base = transl(-12.2, -1.8, 0);
            obj.qz = zeros(length(L));

        end
    end
end
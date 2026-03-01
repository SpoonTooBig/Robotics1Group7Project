classdef DrawBot < SerialLink
    properties  
    qz
    end
    methods
        function obj = DrawBot()
            deg = pi/180;
            L(1) = Revolute('d', 0, ...   % link length (Dennavit-Hartenberg notation)
            'a', 9.5, ...               % link offset (Dennavit-Hartenberg notation)
            'alpha', 0, ...        % link twist (Dennavit-Hartenberg notation)
            'offset', 7*deg, ...
            'qlim', [-160 160]*deg ); % minimum and maximum joint angle
        
            L(2) = Revolute('d', 1.8, ...   % link length (Dennavit-Hartenberg notation)
            'a', 8, ...               % link offset (Dennavit-Hartenberg notation)
            'alpha', 0, ...        % link twist (Dennavit-Hartenberg notation)
            'offset', 97*deg, ...
            'qlim', [-160 160]*deg ); % minimum and maximum joint angle

            obj@SerialLink(L, 'name', 'DrawBot');
            obj.base = transl(12.2, 1.8, 7.8);
            obj.qz = zeros(length(L));

        end
    end
end
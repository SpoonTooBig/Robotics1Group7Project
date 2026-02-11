% Code defining dimensions and DH parameters for group 7's drawbot

clear L
deg = pi/180;

L(1) = Revolute('d', 0, ...   % link length (Dennavit-Hartenberg notation)
    'a', 8.8, ...               % link offset (Dennavit-Hartenberg notation)
    'alpha', 0, ...        % link twist (Dennavit-Hartenberg notation)
    'qlim', [-160 160]*deg ); % minimum and maximum joint angle

L(2) = Revolute('d', 1.8, ...   % link length (Dennavit-Hartenberg notation)
    'a', 10.5, ...               % link offset (Dennavit-Hartenberg notation)
    'alpha', 0, ...        % link twist (Dennavit-Hartenberg notation)
    'qlim', [-160 160]*deg ); % minimum and maximum joint angle

L3 = Prismatic('theta', pi/2, 'a', 0, 'alpha', 0, 'qlim', [0 12.5]);

qz = [0 0 0]; % zero angles, L shaped pose

drawbot = SerialLink(L, 'name', 'DrawBot');
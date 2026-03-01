function q = IK_closed_2R(x, y, L1, L2)
% Inputs:
%   x, y  → desired end-effector position in the plane
%   L1    → length of link 1
%   L2    → length of link 2
% Output:
%   q     → joint angles [q1 q2] in radians

c2 = (x^2 + y^2 - L1^2 - L2^2)/(2*L1*L2);
s2 = sqrt(1 - c2^2);        

q2 = atan2(s2, c2);
q1 = atan2(y, x) - atan2(L2*sin(q2), L1+L2*cos(q2));

q = [q1 q2]; %   q     → joint angles [q1 q2] in radians
end



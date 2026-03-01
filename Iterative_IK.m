function q = Iterative_IK(x, y, L1, L2)

% initial guess
q = [0 0];          % [q1 q2] radians

% solver settings
alpha = 0.5;        % step size
tol = 1e-6;         % position tolerance
maxIter = 1000;

for k = 1:maxIter

    % current end-effector position (FK)
    xk = L1*cos(q(1)) + L2*cos(q(1)+q(2));
    yk = L1*sin(q(1)) + L2*sin(q(1)+q(2));

    % position error
    e = [x - xk;
         y - yk];

    if norm(e) < tol
        break
    end

    % Jacobian for 2R planar arm
    J = [ -L1*sin(q(1)) - L2*sin(q(1)+q(2)),  -L2*sin(q(1)+q(2));
           L1*cos(q(1)) + L2*cos(q(1)+q(2)),   L2*cos(q(1)+q(2)) ];

    % joint update (Jacobian transpose method)
    q = q + alpha * J' * e;

end

end
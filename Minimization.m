robot = DrawBot;

ds = robot.d';
as = robot.a';
alphas = robot.alpha';
offsets = robot.offset';

dhParams = [ds, as, alphas, offsets];
base = [12.2; 1.8];

x0_params = [dhParams base];
options = optimset('OutputFcn',@save_history, 'MaxFunEvals', 1000);
[dhParams, error] = fminsearch(@(robotParams)DHObjFunc(robotParams, 0), x0_params, options);

dhParams
error

% Plot the captured history
figure;
plot(error_history, '-o', 'LineWidth', 1.5);
xlabel('Iteration');
ylabel('Error (Objective Function Value)');
title('Error History of fminsearch');
grid on;

% --- The Output Function ---
function stop = save_history(x, optimValues, state)
    global error_history;
    stop = false;
    if strcmp(state, 'iter')
        % optimValues.fval is the "error" at the current iteration
        error_history(end+1) = optimValues.fval;
    end
end
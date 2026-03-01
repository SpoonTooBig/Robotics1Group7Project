robot = DrawBot;

ds = robot.d';
as = robot.a';
alphas = robot.alpha';
offsets = robot.offset';

dhParams = [ds, as, alphas, offsets];
base = [12.2; 1.8];

x0_params = [dhParams base];
options = optimset('MaxFunEvals', 1000);
x = fminsearch(@(robotParams)DHObjFunc(robotParams, 1), x0_params, options)



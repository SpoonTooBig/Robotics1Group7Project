robot = DrawBot;

ds = robot.d';
as = robot.a';
alphas = robot.alpha';
offsets = robot.offset'

dhParams = [ds, as, alphas, offsets];
base = [12.2; 1.8];

robotParams = [dhParams base];
options = optimset('MaxFunEvals', 10000)
fminsearch(@(robotParams)DHObjFunc(robotParams), robotParams, options)

robotParams
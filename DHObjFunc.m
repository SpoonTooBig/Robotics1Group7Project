function [e] = DHObjFunc(DH_parameters, plot)
    theta = [0 0; 90 0; 90 -90; 135 0; 90 -45]*pi/180;
    data = [21 8.5; 5 9.5; 13.5 20.2; 1.5 1.8; 6 16.5];
    
    %create a new robot using the input Dh parameters
    L(1) = Link('revolute', 'd',DH_parameters(1,1),'a', DH_parameters(1,2),'alpha',DH_parameters(1,3),'offset',DH_parameters(1,4),'standard');%Link 1
    L(2) = Link('revolute', 'd',DH_parameters(2,1),'a', DH_parameters(2,2),'alpha',DH_parameters(2,3),'offset',DH_parameters(2,4),'standard');%Link 2
    jRobot = SerialLink(L,'name','Jeni Robot');

    jRobot.base = transl(DH_parameters(1,5), DH_parameters(2, 5), 7.8);
    
    e = 0;%initalize error
    if plot
        jRobot.plot([0 0])
    end
    %for loop here
    for i = 1:5
        % get pose         
        q = [theta(i, 1), theta(i, 2)];
        %compute the forward kinematics
        T = jRobot.fkine(q);
    
        %find the end-effector position
        position = T.t;
        xPosition = position(1,1);
        yPosition = position(2,1);  
    
        e = e + sqrt((xPosition-data(i,1))^2 + (yPosition-data(i,2))^2 );%use the distance formula
    
    end
    e = e/5; %divide by five because there are 5 data points
end
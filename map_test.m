map = zeros(100,100);

map(84:90,8:40) = 1;%left eyebrow
map(84:90,60:92) = 1;%right eyebrow
map(66:78,22:36) = 1;%left eye
map(66:78,64:78) = 1;%right eye
map(40:46,40:60) = 1;%nose
map(24:50,10:16) = 1;%left smile 
map(24:50,84:90) = 1;%right smile 
map(10:24,10:90) = 1;%bottom smile 

figure(1)
imagesc(map)
colormap(flipud(gray)); % Black for obstacles, white for free space
grid on
axis equal;
axis([0 100 0 100]);
title('100x100 Costmap');
xlabel('X-axis');
ylabel('Y-axis');

%map(1,:) = 1;
goal = [50,50];
start = [1,2];
dx = DXform(map);
dx.plan(goal);
p = dx.query(start,'animate');
%p = dx.path(start);
numrows(p)
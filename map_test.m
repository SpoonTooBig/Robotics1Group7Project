
map = zeros(100,100);

map(10:16,8:40) = 1;%left eyebrow
map(10:16,60:92) = 1;%right eyebrow
map(22:34,22:36) = 1;%left eye
map(22:34,64:78) = 1;%right eye
map(40:46,40:60) = 1;%nose
map(50:76,10:16) = 1;%left smile 
map(50:76,84:90) = 1;%right smile 
map(76:88,10:90) = 1;%bottom smile 

figure(1)
imagesc(map)
colormap(flipud(gray)); % Black for obstacles, white for free space
grid on
axis equal;
axis([0 100 0 100]);
title('100x100 Costmap');
xlabel('X-axis');
ylabel('Y-axis');
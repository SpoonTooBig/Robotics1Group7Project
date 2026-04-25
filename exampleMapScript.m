s = SevenBot();
m = Map(5, 11, 8, 8, s)

% Navigate using DStar
m.NavigateMap([50 50], [1 1], 1)

% Navigate using PRM
m.NavigateMap([50 50], [100 1], 2)
function PLOT_Circle(Cnt, R, n, a)

t = linspace(0, 2*pi, 1000);
x = R * cos(t) + Cnt(1);
y = R * sin(t) + Cnt(2);

plot(x, y, a, 'LineWidth', n);

end


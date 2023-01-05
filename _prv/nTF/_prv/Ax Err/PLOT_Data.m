function PLOT_Data(Pz, Lz, Sd, nD, nZ, sX, sY, nF, nL)

hold on;
grid on;

for id = 1:nD
    stairs(Lz(1:nZ+1), Pz(1:nZ+1, id), 'linewidth', nL);
end

xlabel(sX, 'FontSize', nF, 'fontweight', 'b');
ylabel(sY, 'FontSize', nF, 'fontweight', 'b');

legend(Sd,  'FontSize', nF, 'FontWeight', 'b')
set   (gca, 'FontSize', nF, 'FontWeight', 'b')

end
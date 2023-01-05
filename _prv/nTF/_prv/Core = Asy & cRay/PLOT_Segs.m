function PLOT_Segs(Cnt, Pts, nPt, n, a)

for iPt = 1:nPt-1
    plot([Cnt(1) + Pts(1,iPt), Cnt(1) + Pts(1,iPt+1)], [Cnt(2) + Pts(2,iPt), Cnt(2) + Pts(2,iPt+1)], a, 'LineWidth', n);
end

end


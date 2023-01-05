function PLOT_Pts(Pts, nPt, a)

for iPt = 1:nPt
    scatter(Pts(1, iPt), Pts(2, iPt), a);
end

end


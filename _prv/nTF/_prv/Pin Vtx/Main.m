clc;
close all;
clear;
% ------------------------------------------------
%                  PLOT : Pin Vtx
% ------------------------------------------------
aoF2F = 4.61881388702243;
%aoF2F = 6.000869094655847;
%aoF2F = 20.6114046100696;

aoPch = aoF2F / sqrt(3.);

for iBndy = 1:7
  Theta = pi * 0.5 - pi * (iBndy - 1) / 3.;
  
  AsyVtx(1, iBndy) = aoPch * cos(Theta);
  AsyVtx(2, iBndy) = aoPch * sin(Theta);
end

Eqn01 = [sqrt(3.), 1., 0.];
Eqn02 = [0., 1., 0.];
Eqn03 = [-sqrt(3.), 1., 0.];

fid = fopen('TST PIN VTX');

while  (~feof(fid))
    tline = fgetl(fid);
    Intro = textscan(tline, '%s', 100);
    nPin  = sscanf(Intro{1}{2}, '%d');
    
    hold on;
    axis equal;
    
    xlim([-aoF2F*0.6 aoF2F*0.6]);
    ylim([-aoPch*1.05  aoPch*1.05]);
    
    for iBndy = 1:6
        PLOT_Seg(AsyVtx(1:2, iBndy), AsyVtx(1:2, iBndy+1), 3, 'r')
    end
    
    PLOT_Line(Eqn01, 3, 'b')
    PLOT_Line(Eqn02, 3, 'b')
    PLOT_Line(Eqn03, 3, 'b')
    
    for iPin = 1:nPin
        tline = fgetl(fid);
        Intro = textscan(tline, '%s', 100);
        
        nBndy = sscanf(Intro{1}{2}, '%d');
        
        if nBndy < 1
           continue 
        end
        
        for iBndy = 1:nBndy+1
            Pts(1, iBndy) = sscanf(Intro{1}{2*iBndy + 1}, '%f');
            Pts(2, iBndy) = sscanf(Intro{1}{2*iBndy + 2}, '%f');
        end
        
        for iBndy = 1:nBndy
            PLOT_Seg(Pts(1:2, iBndy), Pts(1:2, iBndy+1), 1, 'k')
        end
        
        Cnt = FIND_Cnt(nBndy, Pts);
        
        text(Cnt(1), Cnt(2), num2str(iPin));
    end
end

return
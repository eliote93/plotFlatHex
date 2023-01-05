clc; close all; clear;

Fn  = 'TST Pin Typ';
fid = fopen(Fn);

tline = fgetl(fid);
Intro = textscan(tline, '%s', 100);
nPin  = sscanf(Intro{1}{3}, '%d');

XX = []; YY = []; CC = [];

for iPin = 1:nPin
   tline = fgetl(fid);
   Intro = textscan(tline, '%s', 100);
   ipTyp = sscanf(Intro{1}{2}, '%d');
   nPt   = sscanf(Intro{1}{3}, '%d');
   
   tline = fgetl(fid);
   Intro = textscan(tline, '%s', 100); 
   
    Pts = zeros(2, 6);
   
   for iPt = 1:nPt
       Pts(1, iPt) = sscanf(Intro{1}{2*iPt-1}, '%f');
       Pts(2, iPt) = sscanf(Intro{1}{2*iPt},   '%f');
   end
   
   for iPt = nPt+1:6
       Pts(1:2, iPt) = Pts(1:2, nPt);
   end
   
   X  = Pts(1, 1:6);
   Y  = Pts(2, 1:6);
   XX = [XX;X];
   YY = [YY;Y];
   CC = [CC;ones(1,6) * ipTyp];
end

if nPin ~= 0
    patch(XX',YY',CC',CC','LineStyle','None');
end

xlabel('Distance from center, cm', 'FontSize', 30, 'FontWeight', 'bold')
ylabel('Distance from center, cm', 'FontSize', 30, 'FontWeight', 'bold')
set(gca, 'FontSize', 30, 'FontWeight', 'bold')

axis equal

fclose(fid);

return
if exist('constantsLoaded', 'var')
    if constantsLoaded == 1
        return;
    end
end

clc; 

%% CCD Parameters
PIXEL_MAP_SZ_X = 2448;
PIXEL_MAP_SZ_Y = 2048;
GUIDE_CAM_FRAME_RATE = 22; %fps
N=1;
% xIndx = -PIXEL_MAP_SZ_X/2:N:(PIXEL_MAP_SZ_X/2-1);
% yIndx = -PIXEL_MAP_SZ_Y/2:N:(PIXEL_MAP_SZ_Y/2-1);
xIndx = 1:PIXEL_MAP_SZ_X;
yIndx = 1:PIXEL_MAP_SZ_Y;
%% Fiber bundle image parameters
nominalFiberCenter = [PIXEL_MAP_SZ_X/2,PIXEL_MAP_SZ_Y/2];

fiberCenterOffset = [0 50];

fiberCenter = nominalFiberCenter+fiberCenterOffset;
fiberRadius = 50;
fiberMask = getFiberMask(fiberCenter, ...
    fiberRadius, ...
    [PIXEL_MAP_SZ_X PIXEL_MAP_SZ_Y]);
% image(fiberMask) ;
% colormap([0 0 0; 1 1 1]);

%% Star image parameters
Gain = 2^8;
starLoc = [500 500];
starRadius = 100;
[X,Y] = meshgrid(xIndx,yIndx );
starPixels = (Y - starLoc(1)).^2 + (X - starLoc(2)).^2 <= starRadius^2;
starPixels = double(starPixels)*Gain;
H = fspecial('disk',8);
% starPixels = imfilter(starPixels,H,'replicate');
for ii = 1:50
    starPixels = imfilter(starPixels,H,'conv');
end

%% Done.
constantsLoaded = 1;
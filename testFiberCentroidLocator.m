close all; clear;
loadConstants;



starPixelsShifted = starPixels;

% starPixelsShifted(~fiberMask) = 0;

% Vector from star location to nominal fiber location
shiftVector = nominalFiberCenter-starLoc;
% Magnitude of that vector
shiftVectorMag = norm(shiftVector);
% Unit vector in that direction
shiftUnitVector = shiftVector/shiftVectorMag;
% Number of steps to take while scanning in that direction
% Note: Update this to only go to the edge of the error circle
numShiftSteps = round(shiftVectorMag*2/starRadius);
% shiftVectorStep = fliplr(shiftVector/numShiftSteps);
shiftVectorStep = starRadius*shiftUnitVector;


f101 = figure(101);
% colormap('gray');
image(starPixelsShifted);
imgAxes = gca;
lineAxes = axes('Position', imgAxes.Position);
% line([starLoc(1) starLoc(1)+shiftVector(1)], ...
%     [starLoc(2) starLoc(2)+shiftVector(2)]);
quiver(starLoc(1), starLoc(2),  ...
    shiftVector(1), shiftVector(2), 'r');
hold on
viscircles(nominalFiberCenter, fiberRadius, 'Color','m', 'LineWidth', 1)
lineAxes.YDir = 'reverse';
linkaxes([imgAxes lineAxes], 'xy')
axis off
axes(imgAxes);
uistack(lineAxes);

combinedStarPixels = zeros(size(starPixelsShifted));
for ii = 1:numShiftSteps
    starPixelsShifted = imtranslate(starPixelsShifted, shiftVectorStep);
    combinedStarPixels = combinedStarPixels + starPixelsShifted;
    combinedStarPixels(~fiberMask) = 0;
    image(combinedStarPixels) ; uistack(lineAxes); pause(0.2);
end


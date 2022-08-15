function fiberMask = getFiberMask(fiberCenter, fiberRadius, imgSize)

if length(imgSize) ~= 2
    error ('imgSize must be a 1x2 vector');
end

[columnsInImage, rowsInImage] = meshgrid(1:imgSize(1), 1:imgSize(2));

fiberMask = (rowsInImage - fiberCenter(2)).^2 ...
    + (columnsInImage - fiberCenter(1)).^2 > fiberRadius.^2;
end
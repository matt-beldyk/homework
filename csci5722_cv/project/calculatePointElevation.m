function [pixelHeight] = calculatePointElevation(distance, myElevation, farElevation, picHeight)

angle = atan((farElevation - myElevation)/distance);
pixelHeight = floor(picHeight*(angle+(pi/2))/pi);
if pixelHeight == 0
    pixelHeight = 1;
end

end
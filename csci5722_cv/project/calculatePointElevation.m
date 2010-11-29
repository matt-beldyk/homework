function [pixelHeight, angle] = calculatePointElevation(distance, myElevation, farElevation, picHeight, maxClipAngle)

angle = atan((farElevation - myElevation)/distance);
pixelHeight = floor(picHeight*(angle/maxClipAngle));

if pixelHeight == 0
    pixelHeight = 1;
end

if pixelHeight > picHeight
    pixelHeight = picHeight -1;
end

end
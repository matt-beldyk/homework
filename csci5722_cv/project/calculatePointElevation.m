function [pixelHeight, angle] = calculatePointElevation(distance, myElevation, farElevation, picHeight)

angle = atan((farElevation - myElevation)/distance);
pixelHeight = floor(picHeight*(angle)*10);

if pixelHeight == 0
    pixelHeight = 1;
end

if pixelHeight > picHeight
    pixelHeight = picHeight -1;
end

end
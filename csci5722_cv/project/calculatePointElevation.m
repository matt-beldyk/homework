function [pixelHeight, angle] = calculatePointElevation(distance, myElevation, farElevation, picHeight, maxClipAngle)

angle = atan((farElevation - myElevation)/distance) + pi/2;

normedAngle = angle/(pi);

pixelHeight = floor((picHeight/maxClipAngle) * normedAngle);

%if(pixelHeight>100)
 %   sprintf('angle=%f, nAngle=%f, pixelHeight=%d',angle, normedAngle, pixelHeight)
%end
if pixelHeight == 0
    pixelHeight = 1;
end

if pixelHeight > picHeight
    pixelHeight = picHeight -1;
end

end
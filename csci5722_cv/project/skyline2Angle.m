function [angleSkyline] = skyline2Angle(absSkyline, imgH, vertFieldOfView)
    angleSkyline = vertFieldOfView * absSkyline / imgH;
end
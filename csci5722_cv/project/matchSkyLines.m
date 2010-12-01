function [offset, scale] = matchSkyLines(photoSkyline, modelSkyline, photoAngleHint)
    if not(photoAngleHint)
        % Math via http://www.bobatkins.com/photography/technical/field_of_view.html
        photoAngleHint = 35.6;
    end
end
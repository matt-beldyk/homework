function [ximg] = findSkylineSobelHorz(colorImg, monoImg)
    sobConv = [-1 -2 -1; 0 0 0; 1 2 1];
    
    ximg = conv2(double(monoImg), double(sobConv), 'same');
    
    sprintf('max=%f, min=%f, mean=%f, median=%f', max(max(ximg)), min(min(ximg)), mean(mean(ximg)), median(median(ximg)))

    
    absMax = max(max(abs(ximg)));
    
    threash = .80;
    threashMax = (1 - threash) * absMax;
    msk = abs(ximg) > threashMax;
    size(msk)
    ximg = msk .* ximg;
    
   % ximg = abs(ximg / max(max(abs(ximg))));
    %skyline(:,:,1) = ximg;
   %% skyline(:,:,2) = ximg;
   % skyline(:,:,3) = ximg;
end
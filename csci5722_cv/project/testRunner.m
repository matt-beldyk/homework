function[angleSkyline, photoSkyline, radModelSkyline] = testRunner()
    

    % INIT  
    
    % http://www.flickr.com/photos/bevis/4965206112/
    actualPic = imread('~/homework_data/cv_project/tetonsMedCropped.png');

    
    photoWidth = 150;
    
    colorPic = imresize(actualPic, [nan photoWidth]);
    [imgH, imgW, tmp] = size(colorPic)
    
    vertFieldOfView = deg2rad(24.2) ; %degree
    horzFieldOfView = deg2rad(35.6); %degree
    
    %monoPic = rgb2gray(colorPic);    
    monoPic = rgb2gray(colorPic);
    
    targetH = 600;
    targetW = ceil(photoWidth * (2*pi)/ horzFieldOfView);
    
    
    % Find picture Skyline!!
    ximg = findSkylineSobelHorz(colorPic, monoPic);
   
    photoSkyline = findSkyEdge(ximg);
    
    % Draw all over my photo
    %photoSkyline'
    for i = 1:size(photoSkyline)
        if photoSkyline(i)
            colorPic(photoSkyline(i),i,:) = [0 255 0];
        end
    end
    
    % Rendering my optimal skyline
    [angleCloud, cleanedCloud, pic] = skylineFromInTetons(targetH,targetW);
    
    modelSkyline = findSkylineFromPointCloud(angleCloud);
    [cloudH, cloudW, tmp] = size(angleCloud)
    
    radModelSkyline = pi * modelSkyline/cloudH;
    
    figure(1);
    image(colorPic);
    
    figure(2);
    hold on;
     image(flipdim(abs(ximg),1))
    colormap(hsv(max(max(abs(ximg))) ))
    hold off;
    
   % photoSkyline = cleanUpZeros(photoSkyline);
    
    angleSkyline = skyline2Angle((imgH - photoSkyline).*(photoSkyline > 1), imgH, vertFieldOfView);

    
    
    figure(3);
    plot(angleSkyline);
    
    figure(4);
    plot(radModelSkyline);
    
    offset =   matchSkyLines(angleSkyline, radModelSkyline)
    
   % radModelSkyline(offset,:) = max(max(radModelSkyline));
    
   % figure(5);
  %  plot(radModelSkyline);
    
end
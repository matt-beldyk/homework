function[] = testRunner()
    

    % INIT  
    
    % http://www.flickr.com/photos/bevis/4965206112/
    colorPic = imread('~/homework_data/cv_project/tetonsMedCropped.png');
    [imgH, imgW, tmp] = size(colorPic)
    
    vertFieldOfView = deg2rad(24.2) ; %degree
    horzFieldOfView = deg2rad(35.6); %degree
    monoPic = rgb2gray(colorPic);
    
    
    
    
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
    [angleCloud, cleanedCloud, pic] = skylineFromInTetons();
    
    modelSkyline = findSkylineFromPointCloud(angleCloud);
    [cloudH, cloudW, tmp] = size(angleCloud)
    
    radModelSkyline = pi * modelSkyline/cloudH;
    
    figure(1);
    image(colorPic);
    
    figure(2);
    hold on;
     image(flipdim(abs(ximg),1))
    colormap(hsv(max(max(abs(ximg))) ))
    angleSkyline = skyline2Angle((imgH - photoSkyline).*(photoSkyline > 1), imgH, vertFieldOfView);
    hold off;
    
    
    figure(3);
    plot(angleSkyline);
    
    figure(4);
    plot(radModelSkyline);
    
  %  matchSkyLines(angleSkyline, photoSkyline)
end
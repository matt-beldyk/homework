function[] = testRunner()
    % http://www.flickr.com/photos/bevis/4965206112/
    colorPic = imread('~/homework_data/cv_project/tetonsMed.jpg');
    vertFieldOfView = 24.2 ; %degree
    horzFieldOfView = 35.6; %degree
    monoPic = rgb2gray(colorPic);
    ximg = findSkylineSobelHorz(colorPic, monoPic);
  

   
    photoSkyline = findSkyEdge(ximg);
    photoSkyline'
    for i = 1:size(photoSkyline)
        if photoSkyline(i)
            ximg(photoSkyline(i),i) = max(max(ximg));
        end
    end
     image(abs(ximg))
    colormap(hsv(max(max(abs(ximg))) ))
  %  matchSkyLines(angleSkyline, photoSkyline)
end
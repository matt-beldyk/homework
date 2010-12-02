function[] = testRunner()
    colorPic = imread('~/homework_data/cv_project/lakeJenny1.jpg');
    monoPic = rgb2gray(colorPic);
    ximg = findSkylineSobelHorz(colorPic, monoPic);
  

   
    photoSkyline = findSkyEdge(ximg);
    photoSkyline'
    for i = 1:size(photoSkyline)
        ximg(photoSkyline(i),i) = max(max(ximg));
    end
     image(abs(ximg))
    colormap(hsv(max(max(abs(ximg))) ))
  %  matchSkyLines(angleSkyline, photoSkyline)
end
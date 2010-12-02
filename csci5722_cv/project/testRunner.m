function[] = testRunner()
    colorPic = imread('~/homework_data/cv_project/lakeJenny1.jpg');
    monoPic = rgb2gray(colorPic);
    ximg = findSkylineSobelHorz(colorPic, monoPic);
    image(ximg)
    photoSkyline = findSkyEdge(ximg);
    matchSkyLines(angleSkyline, photoSkyline)
end
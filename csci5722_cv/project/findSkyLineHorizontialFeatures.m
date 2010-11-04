function [annotatedImage, skyLine] = findSkyLineHorizontialFeatures(colorImg, filterSize)

    showVariousVertFilters(rgb2gray(colorImg), filterSize);
end

function [] = showVariousVertFilters(img, filterSize)
  
        py = create_filter(filterSize);
        imgx = filter2(py,img);
        imshow(imgx/255);

end

function [f] = create_filter(n)
    f = zeros(3*n, 1);
    f(1:n, : ) = -1;
    f(2*n + 1:end, :) = 1;
    
end
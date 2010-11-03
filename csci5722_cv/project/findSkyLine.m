function [annotatedImage, skyLine] = findSkyLine(colorImg)


    %image(img)
    ximg = edge(rgb2gray(colorImg), 'canny')
    skyLine = findSkyEdge(ximg);
   % imshow(ximg)
    [w,h, c] = size(colorImg);
    size(skyLine);
    annotatedImage = colorImg;
    for i = 1:h
        for j = 1:w
            if ximg(j,i)
                annotatedImage(j,i,:) = [0,255,0];
            end
        end
    end
    for i = 1:h
        if skyLine(i)
            annotatedImage(skyLine(i),i,:) = [255,0,0];
        end
    end
  %  pause
    %image(colorImg)
end

function [skyline] = findSkyEdge(edgedImg)
    [h,w] = size(edgedImg);
    skyline = zeros(w,1);
    for i = [1:w]
        for j = [1:h]
            if edgedImg(j,i)
                skyline(i) = j;
                break
            end
        end
    end
end
function [] = showVariousVertFilters(img)
    hold on;
    for i = 1:20
        py = create_filter(i);
        imgx = filter2(py,img);
        imshow(imgx/255);
        pause
    end
end

function [f] = create_filter(n)
    f = zeros(3*n, 3*n);
    f(1:n, : ) = -1;
    f(2*n + 1:end, :) = 1;
    
end
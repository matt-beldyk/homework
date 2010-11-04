function [annotatedImage, skyLine] = findSkyLineHighestCannyEdge(colorImg, monoImg)


    %image(img)
 %   ximg = edge(rgb2gray(colorImg), 'canny')
   %ximg = edge(rgb2gray(colorImg), 'sobel');
    ximg = edge(monoImg, 'sobel', 'horizontal');
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
    peaks = findPeaks(skyLine, 10)
    for i = 1:size(peaks)
        annotatedImage(skyLine(i), i ,:) = [0, 0, 255];
    end
  %  pause
    %image(colorImg)
end

function [peaks] = findPeaks(skyLine, winSize)
    [count, tmp] = size(skyLine);
    peakCount = 1;
    peaks = [];
    for i = [winSize :count-winSize]
        skyLine(i - winSize +1 : i+winSize)
        % is a local max
        if skyLine(i) > skyLine(i - winSize +1 : i+winSize)
            peaks(peakCount) = i;
            peakCount = peakCount + 1;
        end
    end
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

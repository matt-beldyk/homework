function [] = showSomeImages(pth)
    images = read_files(pth)
    [count,tmp] = size(images)

    
   for i = 1:count
    %       doKmeans(images{i});
    picture = findSkylineSobelHorz(images{i}, rgb2gray(images{i}));
     %  picture = findSkyLineHighestCannyEdge(images{i}, rgb2gray(images{i}));
      image(picture)
       pause
   end
   
end

function [] = doKmeans(img)
     i = 6;
    [mu, mask] = kmeans(img, i);
    imshow(mask/i)
    
end
function [] = multiSizeFilt(images)
        for j = [1 2 3 5 7 10]
            j
            findSkyLineHorizontialFeatures(images{i},j);
            %image(picture)
            pause
        end
end
function [images] = read_files(pth)
    listing = dir(strcat(pth, '*.jpg'))
    [fcount] = size (listing);

    %images = zeros(fcount,
    images = cell(fcount, 1);
    for i = 1:fcount
        fname = strcat(pth, listing(i).name)
        images{i} = imread(fname);
    end
 

end
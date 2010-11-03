function [] = showSomeImages(pth)
    images = read_files(pth)
    [count,tmp] = size(images)
    for i = 1:count
        picture = findSkyLine(images{i});
        image(picture)
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
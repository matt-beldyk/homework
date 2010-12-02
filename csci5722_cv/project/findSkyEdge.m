
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

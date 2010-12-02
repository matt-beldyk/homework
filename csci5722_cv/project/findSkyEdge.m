
function [skyline] = findSkyEdge(edgedImg)
    [h,w] = size(edgedImg);
    skyline = zeros(w,1);
    for i = [1:w]
        for j = [2:h]
            if edgedImg(j,i)
                sprintf('%d,%d found %f', j,i,edgedImg(j,i))
                skyline(i) = j;
                break
            end
        end
    end
end

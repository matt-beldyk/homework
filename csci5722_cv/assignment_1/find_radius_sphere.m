% Matthew Beldyk
% beldyk@colorado.edu

% finds the radius and center point of the sphere based upon the 
% sphere mask file
function [r, center_x, center_y] = find_radius_sphere(mask)
    sizes = size(mask);
    h = sizes(1);
    w = sizes(2);
    min_y=Inf;
    max_y=0;
    min_x=Inf;
    max_x=0;
    
    for x = 1:h
        for y = 1:w
            if mask(x,y) >0 
                if (min_y > y)
                    min_y = y;
                end
                if (min_x > x)
                    min_x = x;
                end
                if (max_y < y)
                    max_y = y;
                end
                if (max_x < x)
                    max_x = x;
                end
            end
        end
    end
    r_x = (max_x - min_x)/2;
    r_y = (max_y - min_y)/2;
    if r_x > r_y
        r = r_x
    else
        r = r_y
    end
    center_x = (max_x + min_x)/2;
    center_y = (max_y + min_y)/2;
end

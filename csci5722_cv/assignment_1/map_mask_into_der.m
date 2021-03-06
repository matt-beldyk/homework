% Matthew Beldyk
% beldyk@colorado.edu

% This function takes a sphere mask, and maps the derivitave for each point
% on the surface of that sphere theoretically in the picture into a vector
% for each point.
function [derv] = map_mask_into_der(mask)
    norms = map_mask_into_norms(mask);
    [h, w] = size(mask);
    derv = zeros(h, w, 3);
    for x = 1:h
        for y = 1:w
           if is_masked(mask, x, y)
                if(norms(x,y,3))
                   derv(x,y,1) = norms(x,y,1)/norms(x,y,3);
                   derv(x,y,2) = norms(x,y,2)/norms(x,y,3);
                    %derv(x,y,1) = 1/norms(x,y,3);
                    %derv(x,y,2) = 1/norms(x,y,3);
                    %derv(x,y,1) = norms(x+1, y, 3) - norms(x,y,3);
                    %derv(x,y,2) = norms(x, y+1, 3) - norms(x,y,3);
                    derv(x,y,3) = 1;
                end
           end
                
           
        end
    end
            
end

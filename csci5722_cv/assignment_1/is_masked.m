% Matthew Beldyk
% beldyk@colorado.edu

% wanted a central place to decide my logic if a part of a picture was
% masked.  I've changed my logic once or twice on this one
function [masked] = is_masked(mask, x, y)
    masked = mask(x,y) == 255 ;
end

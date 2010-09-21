% Matthew Beldyk
% beldyk@colorado.edu

% this function creates a cat normal object.  It is used once the closest
% sphere points for each cat point are stored in mapping
function [cat_norms] = map_cat(mapping, sphere_norms)

[cat_h, cat_w, foo] = size(mapping);
cat_norms = zeros(cat_h, cat_w, 3);

for x = 1:cat_h
    for y = 1:cat_w
        bx = mapping(x,y,1);
        by = mapping(x,y,2);

        if bx && by
    %        matte_vect = matte_pics(bx,by,:,1);
%            matte_cat(x,y,:) = matte_vect/255;
            cat_norms(x,y,:) = sphere_norms(bx,by,:);
        end
    end
end

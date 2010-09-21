function [norms] = map_mask_into_norms(mask)
    [r, center_x, center_y] = find_radius_sphere(mask)
  %  r = r + 1;
    sizes = size(mask);
    norms = zeros(sizes(1), sizes(2), 3);
    for i = 1:sizes(1)
        for j = 1:sizes(2)
            if is_masked(mask, i, j)
                
                norm_x = (i - center_x) ;
                norm_y = (j - center_y)  ;
                norm_z = abs(sqrt((r*r) - (norm_x*norm_x) - (norm_y*norm_y)));
                norms(i,j,:) = [norm_x, norm_y, norm_z];
            end
        end
    end
   norms(center_x, center_y, :) = [100,100,100];
end

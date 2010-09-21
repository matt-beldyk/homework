function [norms] = map_mask_into_norms(mask)
    [r, center_x, center_y] = find_radius_sphere(mask);
    sizes = size(mask);
    norms = zeros(sizes(1), sizes(2), 3);
    for i = 1:sizes(1)
        for j = 1:sizes(2)
            norm_x = i - center_x;
            norm_y = j - center_y;
            norm_z = sqrt(r*r - norm_x*norm_x - norm_y*norm_y);
            norms(i,j,:) = [norm_x, norm_y, norm_z];
        end
    end
end

function [] = track_movement(pth)
  %  xy_mappings = do_it(pth,25);
    
    for i = 1:size(xy_mappings)
        normed_vect = normalize_all_points(xy_mappings{i},cam.f, cam.C(1), cam.C(2));
    end
end

function [normed_vect] = normalize_all_points(m_vect, f, c1, c2)
    K = [f 0 c1; 0 f c2; 0 0 1]
    uv = [u, v, 1]
    y = K\uv
end
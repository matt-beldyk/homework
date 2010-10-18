function [] = track_movement(pth)
  %  xy_mappings = do_it(pth,25);
    load('code_state_oct_12.mat');
    load('/home/beldyk/homework_data/cv_asgn3/cam.mat');
    [asdf, num_img] = size(xy_mappings);
    normed_vect = cell(num_img,1);
    for i = 2:num_img
        normed_vect{i} = normalize_all_points(xy_mappings{i},cam.f, cam.C(1), cam.C(2));
    end

end


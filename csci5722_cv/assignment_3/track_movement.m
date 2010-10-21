function [] = track_movement(pth, iterations)
    xy_mappings = do_it(pth,25);
   % load('~/code_state_oct_12.mat');
    load(strcat(pth,'/cam.mat'));
    [asdf, num_img] = size(xy_mappings);

    all_the_translations = zeros(num_img, 3);
    for i = 2:num_img
        i
        all_the_translations(i, :) = find_best_translation(xy_mappings{i}, pth, iterations);
    end

    plot_translations(all_the_translations);
    save('~/code_state_oct_20.mat');
end


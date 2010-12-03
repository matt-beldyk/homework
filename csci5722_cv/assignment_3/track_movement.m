% Matthew Beldyk
% this function will track the movement of a robot through
% a field, given a directory of .ppm files
% also give the number of ransac iterations to attempt
% I've found 1000 to be a reasonable number

function [] = track_movement(pth, iterations)
    xy_mappings = find_features_and_mappings(pth,25,10);
   % load('~/code_state_oct_12.mat');
    load(strcat(pth,'/cam.mat'));
    [asdf, num_img] = size(xy_mappings);

    all_the_translations = zeros(num_img, 3);
    for i = 2:num_img
        i
        all_the_translations(i, :) = find_best_translation(xy_mappings{i}, pth, iterations);
    end

    all_the_translations
    
    plot_translations(all_the_translations);
   % save('~/code_state_oct_20.mat');
end


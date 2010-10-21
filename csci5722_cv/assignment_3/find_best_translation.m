function [t] = find_best_translation(xy_matches, pth, iterations)
    [count_features, tmp] = size(xy_matches);
    load(strcat(pth, '/cam.mat'));
    normed_xy = normalize_all_points(xy_matches, cam.f, cam.C(1), cam.C(2));
    best_distance = Inf;
    best_which = 0;
    for i =1:iterations
        random_features = normed_xy(randi(count_features, 1,8),:);
        [P, E, whichP] = solve_for_e(random_features);
        if P

            reasonable_features = random_features;
            dist_counter = 0;
            for j = 1:8
                vect = reasonable_features(j,1:2);
                vect(1,3) = 0;
                vect(1,4) = 0;
                mapped_feat = P*vect';
                target_feat = zeros(3,1);
                target_feat(1:2) = reasonable_features(j,3:4)';

                dist_counter = dist_counter + norm(mapped_feat - target_feat);
            end
            if(dist_counter < best_distance)
                best_features = reasonable_features;
                best_distance = dist_counter;
                best_P = P;
                best_which = whichP;
            end
        end
    end
    best_features;
    best_distance;
    best_P;
    de_norm_feats = de_normalize_all_points(best_features, cam.f, cam.C(1), cam.C(2));
    E = find_e(de_norm_feats);
    [u,s,v] = svd(E);
    t = v(:,3)
    
    if or((best_which == 2),(best_which ==4))
        sprintf('gotta flip t')
        t = -t;
    end
end
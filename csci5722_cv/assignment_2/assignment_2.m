function [] = assignment_2()
    pth = '~/homework_data/cv_asgn3/';
    threashold = 10;
    maxMatchDist = 40;
    xy_mappings = find_features_and_mappings(pth, maxMatchDist,threashold);

end
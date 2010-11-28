function [] = assignment_2()
    pth = '/home/beldyk/homework_data/cv_asgn2/';
    threashold = 50;
    maxMatchDist = 40;
    xy_mappings = find_features_and_mappings(pth, maxMatchDist,threashold);

end
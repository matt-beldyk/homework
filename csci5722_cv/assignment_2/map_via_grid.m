% Matthew Beldyk

% This function will take two lists of features for two pictures
% and find a reasonable mapping between the two of them
% it is optimized by placing the features in a grid and only 
% looking for coorespondances via a threshold


function [mappings] = map_via_grid(A,B, w, h, maxDist)
    Ma = map_features_grid(A, w, h);
    Mb = map_features_grid(B, w, h);
    %forward_matches = find_matches(Ma, Mb, w, h, threshold);
    %back_matches = find_matches(Mb, Ma, w, h, threshold);
    %mappings = cyclic_consistancy(forward_matches, back_matches);
    mappings = find_matches(Ma, Mb, w, h, maxDist);
end

% puts the features into a grid
function [M] = map_features_grid(A, w, h)
    M = cell(w,h);
    for i = 1: size(A)
        M{A(i,1), A(i,2)} = A(i,:);
    end
end


% searches the two grids looking for cooresponances between 
% the two of them
function [matches] = find_matches(Ma, Mb, w, h, maxDist)
g = 1;

for i = 1:w
    for j = 1:h
        if(Ma{i,j})
            
            if i>maxDist
                left = i-maxDist;
            else
                left = 1;
            end
            
            if i + maxDist < w
                right = i+maxDist;
            else
                right = w;
            end
            
            if j>maxDist
                up = j-maxDist;
            else
                up = 1;
            end
            
            if j + maxDist < h
                down = j+maxDist;
            else
                down = h;
            end
            min_dist = Inf;
            min_loc = [0,0];
            for k = left:right
                for m = up:down
                    if(Mb{k,m})
                        distance = norm(Ma{i,j} - Mb{k,m});
                        if(distance < min_dist)
                            min_dist = distance;
                            min_loc = [k,m];
                        end
                    end
                end
            end
            matches(g,:) = [i, j, min_loc(1), min_loc(2)];
            g = g+1;
            if(mod(g,100) == 0)
                g;
            end
            
        end
    end
end
end
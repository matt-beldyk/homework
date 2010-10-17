function [mappings] = map_via_grid(A,B, w, h, threshold)
    Ma = map_features_grid(A, w, h);
    Mb = map_features_grid(B, w, h);
    %forward_matches = find_matches(Ma, Mb, w, h, threshold);
    %back_matches = find_matches(Mb, Ma, w, h, threshold);
    %mappings = cyclic_consistancy(forward_matches, back_matches);
    mappings = find_matches(Ma, Mb, w, h, threshold);
end

function [M] = map_features_grid(A, w, h)
    M = cell(w,h);
    for i = 1: size(A)
        M{A(i,1), A(i,2)} = A(i,:);
    end
end

function [matches] = find_matches(Ma, Mb, w, h, threshold)
g = 1;

for i = 1:w
    for j = 1:h
        if(Ma{i,j})
            
            if i>threshold
                left = i-threshold;
            else
                left = 1;
            end
            
            if i + threshold < w
                right = i+threshold;
            else
                right = w;
            end
            
            if j>threshold
                up = j-threshold;
            else
                up = 1;
            end
            
            if j + threshold < h
                down = j+threshold;
            else
                down = h;
            end
            min_dist = Inf;
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
                g
            end
            
        end
    end
end
end
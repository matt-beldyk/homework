% This function will take the collection of feature vectors from two images
% in the series and find their nearest neighbors and make sure that these
% results are consistant if time were moving backwards (Also, I think the
% newest Doctor is pretty cool.)
function [mappings] = find_xy_mappings(A,B)
    forward_matches = find_matches(A,B);
    back_matches = find_matches(B,A);
    mappings = cyclic_consistancy(forward_matches, back_matches);

end


% This funcion searches for the closest vector for every vector
% I'm just looking at euclidian distance 
% (X,Y,Filter Size, is_minima or maxima, filter response)
% I also just map maximas to maximas and minimas to minimas
% I don't want weird hiccups of pointing from a min to a max
function [mp] = find_matches(A,B)
    for i = 1:size(A)
        min_dist = Inf;
        if mod(i,1000) == 0
            i
        end
        for j = 1:size(B)
            if(A(i,4) == B(j,4))
                distance = norm(A(i,:) - B(j,:));
                if(distance < min_dist)
                    min_dist = distance;
                    min_j = j;
                end
            end
        end
        mp(i,:) = [A(i,1), A(i,2), B(min_j,1), B(min_j,2)];
    end
end
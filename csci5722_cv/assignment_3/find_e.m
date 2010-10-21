% Matthew Beldyk

% This function finds the elemenel matrix E based upon 
% a given set of points.
function [E] = find_e(point_matches)
    
    [point_count, tmp] = size(point_matches);
    
    x1 = point_matches(:,1);
    y1 = point_matches(:,2);
    x2 = point_matches(:,3);
    y2 = point_matches(:,4);
    
    A = zeros(point_count, 9);
    for i = 1:point_count
        A(i,:) = [  x1(i)*x2(i), x1(i)*y2(i), x1(i), x2(i)*y1(i), y1(i)*y2(i), y1(i),x2(i), y2(i), 1];
    end

    [U, S, V] = svd(A'*A);
    E = reshape(V(:,9), 3, 3);
    [u, s, v] = svd(E);
    s_tilde = [1 0 0; 0 1 0; 0 0 0];
    E = u*s_tilde*v';
end

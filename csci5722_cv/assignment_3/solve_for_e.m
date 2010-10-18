function [solut] = solve_for_e(point_matches)
    

    x1 = point_matches(:,1)
    y1 = point_matches(:,2)
    x2 = point_matches(:,3)
    y2 = point_matches(:,4)
    
    for i = 1:8
        A(i,:) = [  x1(i)*x2(i), x1(i)*y2(i), x1(i), x2(i)*y1(i), y1(i)*y2(i), y1(i),x2(i), y2(i), 1];
    end
    [U, S, V] = svd(A'*A)
    E = reshape(V(:,9), 3, 3)
    [u, s, v] = svd(E)
    s_tilde = [1 0 0; 0 1 0; 0 0 0]
    E_tilde = u*s_tilde*v'
end
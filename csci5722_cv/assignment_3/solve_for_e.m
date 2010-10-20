function [P] = solve_for_e(point_matches)
    
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
    E_tilde = u*s_tilde*v';
   % [u_tilde, s_tilde, v_tilde] = svd(E_tilde)
    t = u(:,3);

    D = [0 1 0; -1 0 0; 0 0 1];
    
    Ra = u*D*v';
    Rb = u*D'*v';
    
    Pi = cell(4);
    Pi{1} = [Ra t];
    Pi{2} = [Ra -t];
    Pi{3} = [Rb t];
    Pi{4} = [Rb -t];

    P = Pi{1};
    p_counter = [0 0 0 0];
    for i = 1:point_count
        A = [ x1(i)*P(3,:) - P(1,:)
              y1(i)*P(3,:) - P(2,:)
              x2(i)*P(3,:) - P(1,:)
              y2(i)*P(3,:) - P(2,:)];
          
          X = null(A);
          x = X(1,1);
          y = X(2,1);
          z = X(3,1);
          w = X(4,1);
          
          tmp =  (P*X)';
          a = tmp(1);
          b = tmp(2);
          d = tmp(3);
          
          c1 = z*w;
          c2 = d*w;
          

          
          if c1 > 0 && c2 >0
                p_counter(1) = p_counter(1) + 1;
          end
          if c1 < 0 && c2 < 0
                  p_counter(2) = p_counter(2) + 1;

          end
          if c1*c2 < 0
              H = [ 1 0 0                            0
                    0 1 0                            0
                    0 0 1                            0
                    -2*v(1,3)   -2*v(2,3) -2*v(3,3) -1];
                tmp = (H*X)';
                n = tmp(4);
                if z*n > 0
                    p_counter(3) = p_counter(3) + 1;

                else
                    p_counter(4) = p_counter(4) + 1;

                end
          end
          
    end
    P = 0;
    for i = 1:4
        if p_counter(i) == point_count
            P = Pi{i};
        end
    end
    
end



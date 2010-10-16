function [normed_vect] = normalize_all_points(m_vect, f, c1, c2)
    K = [f 0 c1; 0 f c2; 0 0 1]
    K_inv = inv(K)
    [how_many, throwaway] = size (m_vect)
    
    uv = ones(how_many, 6);
    
    uv(:,1:2) = m_vect(:,1:2);
    uv(:,4:5) = m_vect(:,3:4);
    
    for i = 1:how_many
         y(i,1:3) = K_inv * uv(i,1:3)';
         y(i,4:6) = K_inv * uv(i,4:6)';
    end

    normed_vect(:,1:2) = y(:,1:2);
    normed_vect(:,3:4) = y(:,4:5);
end
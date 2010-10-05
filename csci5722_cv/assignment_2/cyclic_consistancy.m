% Matthew Beldyk

% this function makes sure that a result is contained in 
% both a forwards search, and a backwards search
function [union] = cyclic_consistancy(A,B)
    k = 1;
    
    % flip around my results so I can compare if they are equal
    C(:,1) = B(:,3);
    C(:,2) = B(:,4);
    C(:,3) = B(:,1);
    C(:,4) = B(:,2);

    for i = 1:size(A)
        for j = 1:size(C)
            if(A(i,:) == C(j,:))
                union(k,:) = A(i,:);
                k = k +1;
            end
        end
    end
    
end
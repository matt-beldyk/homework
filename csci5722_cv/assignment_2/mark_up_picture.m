% this function basically takes an image and a set of feature_vectors
% and puts a bunch of dots on the black and white image so I can see 
% the features
function [pic] = mark_up_picture(prevFeatVect, thisFeatVect, img)
    pic  = grey2rgb(img);
    green = [0,255,0];
    red = [255,0,0];
    
    [count_feat, foo] = size(thisFeatVect);
    for i = 1:count_feat
            pic(thisFeatVect(i,1), thisFeatVect(i,2), : ) = green;
    end
    
    
    [count_feat, foo] = size(prevFeatVect);
    for i = 1:count_feat
            pic(prevFeatVect(i,1), prevFeatVect(i,2), : ) = red;
    end
    
end

% Does what it looks like, I just wanted another way to monkey with
% images
function [f] = grey2rgb(i)
    f(:,:,1) = i;
    f(:,:,2) = i;
    f(:,:,3) = i;
end

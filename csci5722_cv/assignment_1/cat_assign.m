function [] = cat_assign()

path = '/home/beldyk/Desktop/cat';

% Allocate space for files
cat_pics = zeros(247,220,3,13);
matte_pics = zeros(128,109,3,13);
shiny_pics = zeros(128,109,3,13);

% read in files
for i = 1:13

    cat_file = strcat(path, sprintf('/OBJ_%02d.png',i));
    matte_file = strcat(path, sprintf('/SPHERE_%02d.png',i));
    shiny_file = strcat(path, sprintf('/SHINY_%02d.png',i));
    
    cat_pics(:,:,:,i) = imread(cat_file);
    matte_pics(:,:,:,i) = imread(matte_file);
    shiny_pics(:,:,:,i) = imread(shiny_file);
    
   % kitten(i) = cat_pic;
end
ref_mask = imread(strcat(path, '/spheremask.png'));
cat_mask = imread(strcat(path, '/catmask.png'));
size(ref_mask)

%size(cat_pics)
%pic = cat_pics(:,:,:,6)/255.;
%pixle_space = cat_pics(100,100,:,:)
%pic_size = size(pic);
%image(pic);
shiny_mapping = zeros(247, 220, 2);
matte_mapping = zeros(247, 220, 2);
%for x = 1:247
   
for x = 1:247
    x
    for y = 1:220
        if is_masked(cat_mask, x, y)
            
            cat_vect = reshape(cat_pics(x,y,:,:),39,1);
            [best_sx, best_sy] = find_closest_loc(shiny_pics, ref_mask, cat_vect, 128, 109);
            shiny_mapping(x,y,:) = [best_sx, best_sy];
        
            [best_mx, best_my] = find_closest_loc(matte_pics, ref_mask, cat_vect, 128, 109);
            matte_mapping(x,y,:) = [best_mx, best_my];
        end       
    end
end

matte_cat = zeros(247,220,3);
for x = 1:247
    for y = 1:220
        bx = matte_mapping(x,y,1)
        by = matte_mapping(x,y,2)
        if bx && by
            matte_vect = matte_pics(bx,by,:,1);
            matte_cat(x,y,:) = matte_vect/255;
        end
    end
end
image(matte_cat);
end



function [best_x,best_y] = find_closest_loc(ref_pics,ref_mask, real_vect, w, h)
    best_val = Inf;
    
    for x = 1:w
        for y = 1:h
            if is_masked(ref_mask, x, y)
                ref_vect = reshape(ref_pics(x,y,:,:),13*3,1);
                if(norm(ref_vect-real_vect)<best_val)
                    best_x = x;
                    best_y = y;
                    best_val = norm(real_vect-ref_vect);
                end
            end
        end
    end
end

function [masked] = is_masked(mask, x, y)
    masked = mask(x,y) >0 ;
end





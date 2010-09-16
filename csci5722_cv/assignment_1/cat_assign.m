function [] = cat_assign()

path = '/home/beldyk/Desktop/cat/';
img_count = 13;

cat_pics = allocate_buffer(strcat(path,'OBJ_01.png'), img_count);
matte_pics = allocate_buffer(strcat(path, 'SPHERE_01.png'), img_count);
shiny_pics = allocate_buffer(strcat(path, 'SHINY_01.png'), img_count);

sizes = size(cat_pics);
cat_h = sizes(1);
cat_w = sizes(2);


% read in files
for i = 1:img_count

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
shiny_mapping = zeros(cat_h, cat_w, 2);
matte_mapping = zeros(cat_h, cat_w, 2);
%for x = 1:cat_h
   
for x = 1:30
    x
    for y = 1:cat_w
        if is_masked(cat_mask, x, y)
            
            cat_vect = reshape(cat_pics(x,y,:,:),39,1);
           % [best_sx, best_sy] = find_closest_loc(shiny_pics, ref_mask, cat_vect, 128, 109);
          %  shiny_mapping(x,y,:) = [best_sx, best_sy];
        
            [best_mx, best_my] = find_closest_loc(matte_pics, ref_mask, cat_vect, 128, 109);
            matte_mapping(x,y,:) = [best_mx, best_my];
        end       
    end
end

matte_cat = zeros(cat_h,cat_w,3);
for x = 1:247
    for y = 1:220
        bx = matte_mapping(x,y,1);
        by = matte_mapping(x,y,2);
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

function [pics] = allocate_buffer(file_name, count)
    pics(:,:,:,1) = imread(file_name);
    sizes = size(pics);
    % Allocate space for files
    pics = zeros(sizes(1),sizes(2),sizes(3),count);
end




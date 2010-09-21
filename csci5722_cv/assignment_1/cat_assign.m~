function [] = cat_assign()

img_path = '/home/beldyk/Desktop/cat/';
img_count = 13;

cat_pics = allocate_buffer(strcat(img_path,'OBJ_01.png'), img_count);
matte_pics = allocate_buffer(strcat(img_path, 'SPHERE_01.png'), img_count);
shiny_pics = allocate_buffer(strcat(img_path, 'SHINY_01.png'), img_count);

sizes = size(cat_pics);
cat_h = sizes(1);
cat_w = sizes(2);

path(path, '/home/beldyk/Desktop/');

% read in files
for i = 1:img_count

    cat_file = strcat(img_path, sprintf('/OBJ_%02d.png',i));
    matte_file = strcat(img_path, sprintf('/SPHERE_%02d.png',i));
    shiny_file = strcat(img_path, sprintf('/SHINY_%02d.png',i));
    
    cat_pics(:,:,:,i) = imread(cat_file);
    matte_pics(:,:,:,i) = imread(matte_file);
    shiny_pics(:,:,:,i) = imread(shiny_file);
    
  
end
ref_mask = imread(strcat(img_path, '/spheremask.png'));
cat_mask = imread(strcat(img_path, '/catmask.png'));

[invs, refs] = get_ref_invs(matte_pics, shiny_pics, ref_mask);


mapping = zeros(cat_h, cat_w, 2);


for x = 1:cat_h   
%for x = 1:40
    x
    for y = 1:cat_w
        if is_masked(cat_mask, x, y)
            
            cat_vect = reshape(cat_pics(x,y,:,:),39,1);
            [best_mx, best_my] = find_closest_loc(invs, ref_mask, cat_vect, 128, 109);
            mapping(x,y,:) = [best_mx, best_my];
        end       
    end
end

matte_cat = zeros(cat_h,cat_w,3);
sphere_norms = map_mask_into_norms(ref_mask);
cat_norms = zeros(cat_h, cat_w, 3);

for x = 1:cat_h
    for y = 1:cat_w
        bx = mapping(x,y,1);
        by = mapping(x,y,2);
        
        if bx && by
            matte_vect = matte_pics(bx,by,:,1);
            matte_cat(x,y,:) = matte_vect/255;
            cat_norms(x,y,:) = sphere_norms(bx,by,:);
        end
    end
end
image(matte_cat);
nrml = cat_norms;
x_norm = nrml(:,:,1);
y_norm = nrml(:,:,2);

'about to integrate'
g = integrate_horn2(x_norm, y_norm,cat_mask, 200000, 0);
mesh(g)

save('asgn1.mat', 'nrml')
save('code_state.mat')
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [best_x,best_y] = find_closest_loc(invs, ref_mask, real_vect, w, h)
    best_val = Inf;
    
    for x = 1:w
        for y = 1:h
            if is_masked(ref_mask, x, y)
                inv_mat = reshape(invs(x,y,:,:),39,39);
             %   ref_mat = reshape(ref(x,y,:,:), 2, 39);

               % size(ref_mat*inv_mat*real_vect)
               % size(real_vect)
                if(norm(inv_mat*real_vect - real_vect)<best_val)
                    best_x = x;
                    best_y = y;
                    best_val = norm(inv_mat*real_vect - real_vect);
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

function [pseudo, ref_mat] = get_ref_invs(ref1, ref2,mask)
    sizes = size(ref1);
    h = sizes(1);
    w = sizes(2);
    colors = sizes(3);
    count = sizes(4);

   
    pseudo = zeros(h,w,39,39);
    ref_mat = zeros(h,w,colors*count,2);
    for x = 1:h
        for y = 1:w
            if is_masked(mask,x,y)
                vect1 = reshape(ref1(x,y,:,:),count*colors,1);
                vect2 = reshape(ref2(x,y,:,:),count*colors,1);
                M = [vect1,vect2];
               % size(M)
                ref_mat(x,y,:,:) = M;
               % size(M*inv(M'*M)*M')
                pseudo(x,y,:,:) = M*inv(M'*M)*M';
                inv(M'*M);
            end
        end
    end
    

end



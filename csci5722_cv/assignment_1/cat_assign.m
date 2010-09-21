% Matthew Beldyk
% beldyk@colorado.edu
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
%for x = 1:45
    x
    for y = 1:cat_w
        if is_masked(cat_mask, x, y)
            
            cat_vect = reshape(cat_pics(x,y,:,:),39,1);
            [best_mx, best_my] = find_closest_loc(invs, ref_mask, cat_vect, 128, 109);
            mapping(x,y,:) = [best_mx, best_my];
        end       
    end
end

derv = map_mask_into_der(ref_mask);
cat_map = map_cat(mapping, derv);
nrml = map_cat(mapping, map_mask_into_norms(ref_mask));
y_norm = cat_map(:,:,2);
x_norm = cat_map(:,:,1);
dpth = integrate_horn2(x_norm, y_norm, cat_mask, 2000000, 0);
mesh(dpth)
view(500, 1500);

save('asgn1.mat', 'nrml', 'dpth')
save('code_state1.mat')
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



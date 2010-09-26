% Matthew Beldyk
% beldyk@colorado.edu

% this is the main function the maps a series of images of a ceramic cat
% and some spheres into a 3-d model of said cat
% It takes a really really long time to run
function [] = cat_assign()

% init allocation stuff
img_path = '/home/beldyk/Desktop/cat/';
img_count = 13;

cat_pics = allocate_buffer(strcat(img_path,'OBJ_01.png'), img_count);
matte_pics = allocate_buffer(strcat(img_path, 'SPHERE_01.png'), img_count);
shiny_pics = allocate_buffer(strcat(img_path, 'SHINY_01.png'), img_count);

sizes = size(cat_pics);
cat_h = sizes(1);
cat_w = sizes(2);

% Add in integrate_horn2 since it's not in my repository
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

% read in bit masks
ref_mask = imread(strcat(img_path, '/spheremask.png'));
cat_mask = imread(strcat(img_path, '/catmask.png'));

% precalculate the hard linear algrbra for each point
% so that for search, all I need is a matrix vector multiply
[invs, refs] = get_ref_invs(matte_pics, shiny_pics, ref_mask);

mapping = zeros(cat_h, cat_w, 2);

% find the closest bit of sphere for each pixle of the cat
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

% Calculate the sphere's derivitave
derv = map_mask_into_der(ref_mask);

% Map these deriviative into the cat
cat_map = map_cat(mapping, derv);

% Calculate teh normal vectors of the cat
nrml = map_cat(mapping, map_mask_into_norms(ref_mask));

% Integrate over the slope of the cat
y_norm = cat_map(:,:,2);
x_norm = cat_map(:,:,1);
sizes = size(cat_mask);

%the Mask must be 1's or 0's
cmask = zeros(sizes(1), sizes(2));
for x=1:sizes(1)
    for y=1:sizes(2)
        if(cat_mask(x,y))
            cmask(x,y) = 1;
        end
    end
end

dpth = integrate_horn2(y_norm, x_norm, cmask, 2000000, 0);

% Display the cat
mesh(dpth)
% looks better than mesh, but mesh illustrates my issue
% better)
%surface(dpth)


% Save the required assignment variables
save('asgn1.mat', 'nrml', 'dpth')

% Save the state of the program variables for future reference (and
% debugging)
save('code_state2.mat')
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% This function calcuates the closest sphere points to our given cat point,
% I treat the concat of all colors over all pictures as a single large
% 39x1 vector,  I do similar things for the sphere
function [best_x,best_y] = find_closest_loc(invs, ref_mask, real_vect, w, h)
    best_val = Inf;
    
    % For each point on the sphere
    for x = 1:w
        for y = 1:h
            
            if is_masked(ref_mask, x, y)
                
                % I've pre rendered the vast majority of the least squares
                % for this operation, so I can get away with a 39x39*39x1
                % matrix multiply instead of a solve
                inv_mat = reshape(invs(x,y,:,:),39,39);
             %   ref_mat = reshape(ref(x,y,:,:), 2, 39);

               % size(ref_mat*inv_mat*real_vect)
               % size(real_vect)
               
               % Basically, I'm finding the best linear least squares fit
               % of the shiny and matte spheres for this particular given
               % point. And  then re-subuting that value back in with the 
               % sphere vectors.  Then I'm seeing how good a fit I can do
               % with those points (optimizing for the closest possible)
                if(norm(inv_mat*real_vect - real_vect)<best_val)
                    best_x = x;
                    best_y = y;
                    best_val = norm(inv_mat*real_vect - real_vect);
                end
            end
        end
    end
end



% allocates  an array for each file
function [pics] = allocate_buffer(file_name, count)
    pics(:,:,:,1) = imread(file_name);
    sizes = size(pics);
    % Allocate space for files
    pics = zeros(sizes(1),sizes(2),sizes(3),count);
end

% This function pre-calculates most the least squares math
% and subutions back.
% for each pixle in the spheres
% I start with basically two column vectors, one descibing a pixle
% for both the matte and the shiny spheres
% Let These vectors become a single matrix A
% Let x be the optimal linear combination of these to get to b
% Let b be the vector describing the cat in the various lights
% basically, working through least  squares: x = inv(A'*A)*A*b
% Because eventually, I'll want to subutute x back into the equation
% and see how good my value is, I just pre-calculate parts
% Ax=b => A*inv(A'*A)*A*__b__ = x
% so everything I can determine with A: A*inv(A'*A)*A
% and later on when I'm looking at each pixle thousands of times
% this math is alread completed

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



% Matthew Beldyk
% beldyk@colorado.edu

% this is an ancillary file for running the last steps of my algorithm
% because the search step to find the optimal point on the sphere
% for each point on the cat takes hours, and I'm pretty sure
% that logic is correct
function [] = do_it()
load('code_state2.mat')
%image(matte_cat)

derv = map_mask_into_der(ref_mask);
norms = map_mask_into_norms(ref_mask);
cat_map = map_cat(mapping, derv);
%cat_map = map_cat(mapping, norms)

sizes = size(cat_mask);
cmask = zeros(sizes(1), sizes(2));
for x=1:sizes(1)
    for y=1:sizes(2)
        if(cat_mask(x,y))
            cmask(x,y) = 1;
        end
    end
end


y_norm = cat_map(:,:,2);
x_norm = cat_map(:,:,1);
x_norm;
%g = integrate_horn2(x_norm, y_norm, cat_mask, 3000, 1);
g = integrate_horn2(y_norm, x_norm, cmask, 10000, 1);
%g = integrate_horn2(derv(:,:,1), derv(:,:,2), ref_mask, 3000, 1);
[h,w] = size(g);

dpth = g;
nrml = norms;
% Save the required assignment variables
save('asgn1.mat', 'nrml', 'dpth')

mesh(g)
%surface(g)
%view(500, 1500)
%g
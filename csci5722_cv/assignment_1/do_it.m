function [] = do_it()
load('code_state.mat')
%image(matte_cat)

derv = map_mask_into_der(ref_mask);
cat_map = map_cat(mapping, derv);
y_norm = cat_map(:,:,2);
x_norm = cat_map(:,:,1);
x_norm;
g = integrate_horn2(x_norm, y_norm, cat_mask, 100000, 0);
mesh(g)
view(500, 1500)
g
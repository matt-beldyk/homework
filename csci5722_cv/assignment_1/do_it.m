function [] = do_it()
load('code_state.mat')
image(matte_cat)
derv = map_mask_into_der(ref_mask);
cat_map = map_cat(mapping, derv);
y_norm = cat_map(:,:,2);x_norm = cat_map(:,:,1);
g = integrate_horn2(x_norm, y_norm, cat_mask, 10000, 0);
mesh(g)

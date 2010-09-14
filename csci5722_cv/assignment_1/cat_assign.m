function [] = cat_assign()
path = '/home/beldyk/Desktop/cat';
%i = 1;
%img_file = strcat(path, sprintf('/OBJ_%02d.png',i));
    
%cat_pic = imread(img_file)
%size(cat_pic)
%kitten= zeros(13,size(cat_pic));
%size(kitten)
%kitten(1,:,:,:) = cat_pic;
%cat_pics =[];
cat_pics = zeros(247,220,3,13);
matte_pics = zeros(128,109,3,13);
shiny_pics = zeros(128,109,3,13);
for i = 1:13

    cat_file = strcat(path, sprintf('/OBJ_%02d.png',i));
    matte_file = strcat(path, sprintf('/SPHERE_%02d.png',i));
    shiny_file = strcat(path, sprintf('/SHINY_%02d.png',i));
    
    cat_pics(:,:,:,i) = imread(cat_file);
    matte_pics(:,:,:,i) = imread(matte_file);
    shiny_pics(:,:,:,i) = imread(shiny_file);
    
   % kitten(i) = cat_pic;
end
%size(cat_pics)
pic = cat_pics(:,:,:,6)/255.;
%pixle_space = cat_pics(100,100,:,:)
pic_size = size(pic);
image(pic);






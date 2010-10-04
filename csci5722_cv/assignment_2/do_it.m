function [] = do_it(pth)    
    begin_time = cputime();
    images = read_files(pth);
    [w,h, count_images] = size(images)
    showy = zeros(w,h,3,count_images);
    
  %  count_images = 3;

    xy_mappings = cell(1,count_images - 1);
    feat_vects = cell(1,count_images);

    for i = 1:count_images
        this_image_is = i

        convoluted = do_convolutions(images(:,:,i));
        features = find_features(convoluted);
        feat_vects{1,i} = make_feature_vect(convoluted, features);


        if(i > 1)
            xy_mappings{1,i} = find_xy_mappings(feat_vects{1,i-1}, feat_vects{1,i});
        end
        showy(:,:,:,i) = mark_up_picture(feat_vects{1,i}, images(:,:,i));
    end
    end_time = cputime();
    total_time = end_time - begin_time
    
   % save('code_state.mat');
    show_results(showy, xy_mappings);
    size(xy_mappings);
%    size(showy)
   % for i = 1:count_images
 %       showy(:,:,1,i)
    %    size(showy)
        
    %    image(showy(:,:,:,i)/255)
   %     pause
   % end
    %figure(1);image(showy(:,:,:,1)/255); pause; image(showy(:,:,:,2)/255); hold on; plot([xy(:,2),xy(:,4)]', [xy(:,1), xy(:,3)]'); hold off
end

function [pic] = mark_up_picture(feat_vect, img)
    pic  = grey2rgb(img);
    green = [0,255,0];
    red = [255,0,0];
    [count_feat, foo] = size(feat_vect);
    for i = 1:count_feat
        if( feat_vect(i, 4))
            pic(feat_vect(i,1), feat_vect(i,2), : ) = green;
        else
            pic(feat_vect(i,1), feat_vect(i,2), : ) = red;
        end
        
    end
end


function [feat_vect] = make_feature_vect(conv_mat, features)
    [w,h,n] = size(features);
    i = 1;
    feat_vect = zeros(1,5);
    for x = 1:w
        for y = 1:h
            for z = 1:n
                if(features(x,y,z) == 1)
                    feat_vect(i,:) = [x,y,z,1,conv_mat(x,y,z)];
                    i = i +1;
                end
                if(features(x,y,z) == -1)
                    feat_vect(i,:) = [x,y,z,0,conv_mat(x,y,z)];
                    i = i +1;
                end
            end
        end
    end
end


function [features] = find_features(conv_mat)
features = zeros(size(conv_mat));
[w,h,n] = size(features);
for x = 2:w-1
  %  x
    for y = 2:h-1
        for z = 2:n-1
            

            %top bottom
            is_max = (conv_mat(x,y,z) > max(max(conv_mat(x-1:x+1, y-1, z-1:z+1)))) && (conv_mat(x,y,z) > max(max(conv_mat(x-1:x+1, y+1, z-1:z+1))));
            is_min = (conv_mat(x,y,z) < min(min(conv_mat(x-1:x+1, y-1, z-1:z+1)))) && (conv_mat(x,y,z) < min(min(conv_mat(x-1:x+1, y+1, z-1:z+1))));
            
            %left right
            is_max = is_max && (conv_mat(x,y,z) > max(max(conv_mat(x-1, y-1:y+1, z-1:z+1)))) && (conv_mat(x,y,z) > max(max(conv_mat(x+1, y-1:y+1, z-1:z+1))));
            is_min = is_min && (conv_mat(x,y,z) < min(min(conv_mat(x-1, y-1:y+1, z-1:z+1)))) && (conv_mat(x,y,z) < min(min(conv_mat(x+1, y-1:y+1, z-1:z+1))));
        
            %back front
            is_max = is_max && (conv_mat(x,y,z) > max(max(conv_mat(x-1:x+1, y-1:y+1, z-1)))) && (conv_mat(x,y,z) > max(max(conv_mat(x-1:x+1, y-1:y+1, z+1))));
            is_min = is_min && (conv_mat(x,y,z) < min(min(conv_mat(x-1:x+1, y-1:y+1, z-1)))) && (conv_mat(x,y,z) < min(min(conv_mat(x-1:x+1, y-1:y+1, z+1))));
            
            if is_max 
                features(x,y,z) = 1;
            end
            if is_min
                features(x,y,z) = -1;
            end
        end
    end
end

end

function [convoluted] = do_convolutions(img)
    [w, h ] = size(img);
    convoluted = zeros(w,h, 6);
    size(convoluted);
    filter_sizes = [1,3,5,7,9,11];
    for i = 1:6
        f = create_filter(filter_sizes(i));
   % single(images(:,:,1))

    
        convoluted(:,:,i) =  conv2( single(img),single(f), 'same')/(filter_sizes(i)*filter_sizes(i)*9);   
      %  size(convoluted)
    %    image(convoluted(:,:,i))
       % pause()
    end
end

function [images] = read_files(pth)
    listing = dir(strcat(pth, '*.ppm'))
    [fcount] = size (listing);

    %images = zeros(fcount,
    for i = 1:fcount
        fname = strcat(pth, listing(i).name)
        images(:,:,i) = rgb2gray(imread(fname));
    end
 

end

function [f] = grey2rgb(i)
    f(:,:,1) = i;
    f(:,:,2) = i;
    f(:,:,3) = i;
end

function [f] = create_filter(n)
    f = ones(3*n, 3*n);
    f(n+1:2*n, n+1:2*n) = -8;
    
end
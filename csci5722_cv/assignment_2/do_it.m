function [] = do_it(pth)
images = read_files(pth);
size(images)

convoluted = do_convolutions(images(:,:,1));
features = find_features(convoluted);
feat_vect = make_feature_vect(convoluted, features)
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
[w,h,n] = size(features)
for x = 2:w-1
    x
    for y = 2:h-1
        for z = 2:n-1
            
        if (conv_mat(x,y,z) == max(max(max(conv_mat(x-1:x+1, y-1:y+1, z-1:z+1)))))
            features(x,y,z) = 1;
        end
        if (conv_mat(x,y,z) == min(min(min(conv_mat(x-1:x+1, y-1:y+1, z-1:z+1)))))
            features(x,y,z) = -1;
        end
        end
    end
end

end

function [convoluted] = do_convolutions(img)
    [w, h ] = size(img);
    convoluted = zeros(w,h, 6);
    size(convoluted)
    filter_sizes = [1,3,5,7,9,11]
    for i = 1:6
        f = create_filter(filter_sizes(i));
   % single(images(:,:,1))

    
        convoluted(:,:,i) =  conv2( single(img),single(f), 'same');   
      %  size(convoluted)
    %    image(convoluted(:,:,i))
       % pause()
    end
end

function [images] = read_files(pth)
    listing = dir(strcat(pth, '*.ppm'))
    [fcount] = size (listing)

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
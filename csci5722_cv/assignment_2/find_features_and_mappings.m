% Matthew Beldyk

% This is the main function, basically give it a path to the example
% dataset provided (the *.ppm images of haybales.) and provides an 
function [xy_mappings] = find_features_and_mappings(pth, maxDist, threshold)    
    begin_time = cputime();
    images = read_files(pth);
    [w,h, count_images] = size(images);
    
   % count_images = 20;
    
    showy = zeros(w,h,3,count_images);
    
    %count_images = 3;

    xy_mappings = cell(1,count_images - 1);
    feat_vects = cell(1,count_images);

    for i = 1:count_images
        this_image_is = i;

        % convolute image with all the filters
        convoluted = do_convolutions(images(:,:,i));
        sprintf('processing image %d of %d', i, count_images)
        
        % find all my features for this image
        features = find_features(convoluted, threshold);
       % sprintf('features found %d', i)
        
        % translate these features into more easily mathish vectors
        feat_vects{1,i} = make_feature_vect(convoluted, features);
       % sprintf('feature vects made %d', i)

        % find the mappings from the last image to this one
        if(i > 1)
         %   xy_mappings{1,i} = find_xy_mappings(feat_vects{1,i-1}, feat_vects{1,i});
            xy_mappings{1,i} = map_via_grid(feat_vects{1,i-1}, feat_vects{1,i}, w, h, maxDist);
        end
        
        % mark up an image for my display purposes
        if i > 1
            showy(:,:,:,i) = mark_up_picture(feat_vects{1,i-1},feat_vects{1,i}, images(:,:,i));
        else
            showy(:,:,:,i) = mark_up_picture([], feat_vects{1,i}, images(:,:,i));
        end
    end
    end_time = cputime();
    total_time = end_time - begin_time;
    
    sprintf('total compute time: %f seconds', total_time)
    % uncomment for debugging
   % save('code_state_nov_27.mat');
   
   % Display my results
    show_results(showy, xy_mappings);


end


% this function takes my marked up feature mask and translates it 
% into a bunch of vectors
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



% for every filter size, convolve the image and store the results in 
% a big array of convolved images (a 3-D matrix)
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

% Reads in all the files in a directory and stores them in a matrix
function [images] = read_files(pth)
    listing = dir(strcat(pth, '*.ppm'))
    [fcount] = size (listing);

    %images = zeros(fcount,
    for i = 1:fcount
        fname = strcat(pth, listing(i).name)
        images(:,:,i) = rgb2gray(imread(fname));
    end
 

end


% creates a CenSurE filter of size N
function [f] = create_filter(n)
    f = ones(3*n, 3*n);
    f(n+1:2*n, n+1:2*n) = -8;
    
end

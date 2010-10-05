% This is a simple external function to display the results of my algorithm

function [] = show_results(imgs, xy_mappings)
[w,h, colors, img_count ] = size(imgs);

for i = 1:img_count
    figure(1);
    image(imgs(:,:,:,i)/255.0);
    hold on;
    xy = xy_mappings{1,i}
    if(size(xy))
        plot([xy(:,2),xy(:,4)]', [xy(:,1), xy(:,3)]');
    end
    pause;
    hold off;
    
end
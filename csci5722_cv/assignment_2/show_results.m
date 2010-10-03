function [] = show_results(imgs, xy_mappings)
[w,h, colors, img_count ] = size(imgs)
%figure(1);image(showy(:,:,:,1)/255); pause; image(showy(:,:,:,2)/255); hold on; plot([xy(:,2),xy(:,4)]', [xy(:,1), xy(:,3)]'); hold off
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
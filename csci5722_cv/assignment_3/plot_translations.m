% Matthew Beldyk

% this function plots the translations and locations between all the
% images
function [] = plot_translations(trns)
    [tns_count, tmp] = size(trns)
    loc = zeros(tns_count -1, 2);
    for i = 2:tns_count
        loc(i,:) = loc(i-1,1:2) + trns(i,1:2)
        
    end
%    nxt = loc(2:end,:) +trns(1:end-1,:)
        plot(loc(1:end-1,:), loc(2:end,:));
end
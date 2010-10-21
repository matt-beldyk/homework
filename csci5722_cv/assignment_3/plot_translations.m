function [] = plot_translations(trns)
    [tns_count, tmp] = size(trns)
    loc = zeros(tns_count -1, 3);
    for i = 2:tns_count
        loc(i,:) = loc(i-1,:) + trns(i,:)
        
    end
%    nxt = loc(2:end,:) +trns(1:end-1,:)
        plot(loc(1:end-1,1:2), loc(2:end,1:2));
end
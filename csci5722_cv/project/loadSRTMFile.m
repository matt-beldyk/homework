function [dem] = loadSRTMFile(pth)
    fid = fopen(pth, 'rb', 'ieee-be');
    dem = fread(fid,[3601 3601],  'int16', 'ieee-be');
    foo = size(dem);
    
    % semi normalize missing data
    for i = 1:3601
        for j = 1:3601
            if(dem(i,j) == -32768)
                dem(i,j) = 0;
            end
        end
    end

end
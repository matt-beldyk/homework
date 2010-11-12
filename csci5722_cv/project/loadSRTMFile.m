function [dem] = loadSRTMFile(pth, decimationLevel)
    fid = fopen(pth, 'rb', 'ieee-be');
    gridSize = floor(3601/decimationLevel) + 1;
    dem = downsample(downsample(fread(fid,[3601 3601],  'int16', 'ieee-be'), decimationLevel)', decimationLevel)';
    sprintf('DEM Size %d\n', size(dem))
    
    % semi normalize missing data
    for i = 1:gridSize
        for j = 1:gridSize
            if(dem(i,j) == -32768)
                dem(i,j) = 0;
            end
        end
    end

end
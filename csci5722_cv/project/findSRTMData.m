function [dem] = findSRTMData(lat, lon, decimationLevel)
    pth = sprintf('~/done/SRTM/zipped_data/N%02dW%03d.hgt',lat, lon)
    unzip(sprintf('%s.zip', pth), '~/tmp/')
    dem = loadSRTMFile(sprintf('~/tmp/N%02dW%03d.hgt', lat, lon), decimationLevel);
    
end
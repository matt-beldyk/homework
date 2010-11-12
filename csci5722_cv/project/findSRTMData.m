function [dem] = findSRTMData(lat, lon, decimationLevel)
    pth = sprintf('/home/beldyk/done/SRTM/zipped_data/N%02dW%03d.hgt',lat, lon)
    unzip(sprintf('%s.zip', pth), '/home/beldyk/tmp/')
    dem = loadSRTMFile(sprintf('/home/beldyk/tmp/N%02dW%03d.hgt', lat, lon), decimationLevel);
    
end
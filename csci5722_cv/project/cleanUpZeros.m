function [cleanWaveform] = cleanUpZeros(uncleanWaveform)
    cleanWaveform = uncleanWaveform;
   
    ticker = 1;
    
    for i = 1:size(uncleanWaveform)
        if cleanWaveform(i) > 60
            ticker = cleanWaveform(i);
        else
            cleanWaveform(i) = ticker;
        end
    end
    
end
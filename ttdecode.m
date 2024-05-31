function [decodedDigits, sumOfDigits] = ttdecode(signal2decode)
    
    [numberOfDetectedDigits, digitSignals] = extractDigitSignals(signal2decode);
    
    for i = 1:numberOfDetectedDigits
        signal = cell2mat(digitSignals(i, :));
        ftExtractedDigitSignals{i, :} = abs(fft(signal, 2048));
    end
    
    ftExtractedDigitSignals = cell2mat(ftExtractedDigitSignals);
    
    k = 0:2047;
    omega_k = 2*pi.*k./2048;
    
    for i = 1:numberOfDetectedDigits
    
        ft = fftshift(ftExtractedDigitSignals(i,:), 1);
    
        [~, locations] = findpeaks(ft, "MinPeakHeight", max(ft)/2, "NPeaks", 2);
    
        frequencies = omega_k(locations);
    
        decodedDigits(i) = estimateDigit(frequencies(1), frequencies(2));
    end
    
    sumOfDigits = sum(decodedDigits);
end
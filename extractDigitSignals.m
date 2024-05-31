function [numberOfDetectedDigits, digitSignals] = extractDigitSignals(signal)
    numberOfDetectedDigits = 0;
    isSilence = true;
    signalIndex = 1;
    digitSignals = {}; % Initialize an empty cell array

    % Extract digit signals separated by silence
    for i = 1:length(signal)
        if signal(i) ~= 0 && isSilence
            numberOfDetectedDigits = numberOfDetectedDigits + 1;
            isSilence = false;
            signalIndex = 1;
        end

        % Check for 3 consecutive zeros indicating silence
        if i < length(signal) - 2 && signal(i) == 0 && signal(i+1) == 0 && signal(i+2) == 0
            isSilence = true;
            continue;
        end

        if ~isSilence
            digitSignals{numberOfDetectedDigits, signalIndex} = signal(i);
            signalIndex = signalIndex + 1;
        end
    end
end

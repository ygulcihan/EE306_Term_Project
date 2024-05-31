clear
clc

%% Step 1
samplingFreq = 8192;
% "digits.csv" is constructed using given data
digitData = readtable("digits.csv");

numDigits = height(digitData);

n = 0:1/samplingFreq:0.5;
digitSignals = zeros(numDigits, length(n));

% Generate Signals
for i = 1:numDigits
    signal = sin(digitData.w_row(i)*samplingFreq.*n) + sin(digitData.w_column(i)*samplingFreq.*n);

    % Normalize the signal to have maximum amplitude between [-1,1]
    maxAmplitude = max(abs(signal));
    digitSignals(i, :) = signal / maxAmplitude;
end

% Extract each digit signal to seperate vectors
d0 = digitSignals(1, :);
d1 = digitSignals(2, :);
d2 = digitSignals(3, :);
d3 = digitSignals(4, :);
d4 = digitSignals(5, :);
d5 = digitSignals(6, :);
d6 = digitSignals(7, :);
d7 = digitSignals(8, :);
d8 = digitSignals(9, :);
d9 = digitSignals(10, :);

k = 0:2047;
omega_k = 2*pi.*k./2048;

% Compute DTFT of each signal
fourierTransforms = zeros(numDigits, 2048);
for i = 1:numDigits
    fourierTransforms(i, :) = abs(fft(digitSignals(i, :), 2048));
end

figure("Name", "Haydar Yiğit Gülcihan", "NumberTitle", "off", "Position", [350 175 800 600]);
sgtitle("Part 1: DTFT of Digits 2 & 9");

% Plot DTFT of Digit 2
subplot(2,1,1);
ft2 = fourierTransforms(2 + 1, :); % +1 to compensate for matlab index
plot(omega_k, ft2);
title("Digit 2");
subtitle("Original Frequencies: \omega\_row: " + num2str(digitData.w_row(2 + 1)) + " \omega\_column: " + num2str(digitData.w_column(2 + 1)));
xlabel("\omega (rad/s)")
xlim([0.5 1.25])
ylabel("Magnitude of FT");

[peaks, locations] = findpeaks(ft2, "NPeaks", 2);
frequencies = omega_k(locations);

text(frequencies(1), peaks(1), num2str(frequencies(1)));
text(frequencies(2), peaks(2), num2str(frequencies(2)));

% Plot DTFT of Digit 9
subplot(2,1,2);
ft = fourierTransforms(9 + 1, :); % +1 to compensate for matlab index
plot(omega_k, ft);
title("Digit 9");
subtitle("Original Frequencies: \omega\_row: " + num2str(digitData.w_row(9 + 1)) + " \omega\_column: " + num2str(digitData.w_column(9 + 1)));
xlabel("\omega (rad/s)")
xlim([0.5 1.25])
ylabel("Magnitude of FT");

[peaks, locations] = findpeaks(ft, "NPeaks", 2, "MinPeakHeight", max(ft)/2);
frequencies = omega_k(locations);

text(frequencies(1), peaks(1), num2str(frequencies(1)));
text(frequencies(2), peaks(2), num2str(frequencies(2)));

space = zeros(1, 1000);
myPhoneNumber = [space d5 space d0 space d7 space space d9 space d6 space d4 space space d2 space d5 space space d9 space d1 space];

%% Play sound for phone number
sound(myPhoneNumber, samplingFreq);

%% Steps 2&3

%% Decode X1 (use Run Section for a clean output)
clc
load touch.mat
[x1_decoded, x1_sum] = ttdecode(x1);
fprintf("\n");
disp("X1 decoded: " + num2str(x1_decoded));
disp("Sum of digits in X1: " + num2str(x1_sum));

%% Decode X2 (use Run Section for a clean output)
clc
load touch.mat
[x2_decoded, x2_sum] = ttdecode(x2);
fprintf("\n");
disp("X2 decoded: " + num2str(x2_decoded));
disp("Sum of digits in X2: " + num2str(x2_sum));

%% Decode hardX1 (use Run Section for a clean output)
clc
load touch.mat
[hardx1_decoded, hardx1_sum] = ttdecode(hardx1);
fprintf("\n");
disp("hardX1 decoded: " + num2str(hardx1_decoded));
disp("Sum of digits in hardX1: " + num2str(hardx1_sum));

%% Decode hardX2 (use Run Section for a clean output)
clc
load touch.mat
[hardx2_decoded, hardx2_sum] = ttdecode(hardx2);
fprintf("\n");
disp("hardX2 decoded: " + num2str(hardx2_decoded));
disp("Sum of digits in hardX2: " + num2str(hardx2_sum));

%% Decode myPhoneNumber (5079642591) (use Run Section for a clean output)
clc
load touch.mat
[phone_decoded, ~] = ttdecode(myPhoneNumber);
fprintf("\n");
disp("myPhoneNumber decoded: " + num2str(phone_decoded));

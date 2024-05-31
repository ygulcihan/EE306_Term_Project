function estimatedDigit = estimateDigit(p_w_row, p_w_column)
    digitData = readtable("digits.csv");

    % Calculate the Euclidean distance between the input frequencies and the table frequencies
    for i = 1:height(digitData)
        euclideanDistances(i) = sqrt( (abs(digitData.w_row(i) - p_w_row))^2 + (abs(digitData.w_column(i) - p_w_column))^2 );
    end
    
    % Find the index of the minimum distance
    [~, minIndex] = min(euclideanDistances);
    
    % Get the corresponding digit
    estimatedDigit = digitData.digit(minIndex);

    fprintf("\r\n");
    disp("Extracted Frequencies are " + "w_row: " + num2str(p_w_row, "%1.4f") + ", w_column: " + num2str(p_w_column, "%1.4f"));
    disp("Digit is estimated as " + num2str(estimatedDigit));
    disp("Actual Frequencies of Digit are " + num2str(estimatedDigit) + " are " + "w_row: " + num2str(digitData.w_row(estimatedDigit+1)) + ", w_column: " + num2str(digitData.w_column(estimatedDigit+1)))
end

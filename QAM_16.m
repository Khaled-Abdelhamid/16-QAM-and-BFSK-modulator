M = 16;                     % Size of signal constellation
k = log2(M);                % Number of bits per symbol
n = 200;                  % Number of bits to process
numSamplesPerSymbol = 1;    % Oversampling factor
stem(dataIn(1:40),'filled');
title('Random Bits');
xlabel('Bit Index');
ylabel('Binary Value');

clear
clc
close all

M = 16;                     % Size of signal constellation
k = log2(M);                % Number of bits per symbol
n = 20000;                  % Number of bits to process
numSamplesPerSymbol = 1;    % Oversampling factor

dataIn = randi([0 1],n,1);  % Generate vector of binary data
% repelem(dataIn,numSamplesPerSymbol)

dataInMatrix = reshape(dataIn,length(dataIn)/k,k);   % Reshape data into binary k-tuples, k = log2(M)
dataSymbolsIn = bi2de(dataInMatrix);                 % Convert to integers

dataModG = qammod(dataSymbolsIn,M); % Gray coding, phase offset = 0
% The results are complex column vectors whose values are elements of the 16-QAM signal constellation


% Calculate the SNR when the channel has an Eb/N0 = 10 dB.

EbNo =10;
snr = EbNo + 10*log10(k) - 10*log10(numSamplesPerSymbol);

receivedSignalG = awgn(dataModG,snr,'measured');

sPlotFig = scatterplot(receivedSignalG,1,0,'g.');
hold on
scatterplot(dataModG,1,0,'k*',sPlotFig)

dataSymbolsOutG = qamdemod(receivedSignalG,M);

dataOutMatrixG = de2bi(dataSymbolsOutG,k);
dataOutG = dataOutMatrixG(:);   % Return data in column vector

[numErrorsG,berG] = biterr(dataIn,dataOutG);
fprintf('\nThe Gray coding bit error rate = %5.2e, based on %d errors\n', ...
    berG,numErrorsG)

x = (0:15)';               % Integer input
y2 = qammod(x,16,'gray');  % 16-QAM output, Gray-coded
scatterplot(y2)
text(real(y2)+0.1, imag(y2), dec2bin(x))
title('16-QAM, Gray-coded Symbol Mapping')
axis([-4 4 -4 4])


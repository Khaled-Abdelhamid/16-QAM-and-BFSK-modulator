
clear
clc
close all

M = 16;                     % Size of signal constellation
k = log2(M);                % Number of bits per symbol
n = 20000;                  % Number of bits to process
nsmps = 1;    % Oversampling factor

inputData = randi([0 1],n,1);  % Generate vector of binary data
% repelem(dataIn,numSamplesPerSymbol)

dataInMatrix = reshape(inputData,length(inputData)/k,k);   % Reshape data into binary k-tuples, k = log2(M)
inputsymbols = bi2de(dataInMatrix);                 % Convert to integers

Mdata = qammod(inputsymbols,M); % Gray coding, phase offset = 0
% The results are complex column vectors whose values are elements of the 16-QAM signal constellation


% Calculate the SNR when the channel has an Eb/N0 = 10 dB.

EbNo =10;
snr = EbNo + 10*log10(k) - 10*log10(nsmps);

recSignal = awgn(Mdata,snr,'measured');

sPlotFig = scatterplot(recSignal,1,0,'g.');
hold on
scatterplot(Mdata,1,0,'k*',sPlotFig)

dataSymbolsOutG = qamdemod(recSignal,M);

dataOutMatrixG = de2bi(dataSymbolsOutG,k);
dataOutG = dataOutMatrixG(:);   % Return data in column vector

[numErrorsG,berG] = biterr(inputData,dataOutG);
fprintf('\nThe BER = %5.2e\n',berG)

x = (0:15)';               % Integer input
const = qammod(x,16,'gray');  % 16-QAM output, Gray-coded
scatterplot(const)
text(real(const)+0.1, imag(const), dec2bin(x))
title('16-QAM, Gray-coded Symbol Mapping')
axis([-4 4 -4 4])

% PSD

h = spectrum.welch;
Hpsd= psd(h,Mdata);
figure
plot(Hpsd);

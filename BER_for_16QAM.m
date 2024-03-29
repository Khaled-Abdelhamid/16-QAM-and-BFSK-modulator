
clear
clc
close all

M = 16;                     % Size of signal constellation
k = log2(M);                % Number of bits per symbol
n = 20000;                  % Number of bits to process
nsmps = 1;    % Oversampling factor
max=24;
step=0.125;
size=max/step;
valus=zeros(1,size);
count=1;
for EbNo = 0:step:max
    inputData = randi([0 1],n,1);  % Generate vector of binary data
    % repelem(dataIn,numSamplesPerSymbol)
    
    dataInMatrix = reshape(inputData,length(inputData)/k,k);   % Reshape data into binary k-tuples, k = log2(M)
    inputsymbols = bi2de(dataInMatrix);                 % Convert to integers
    
    Mdata = qammod(inputsymbols,M); % Gray coding, phase offset = 0
    % The results are complex column vectors whose values are elements of the 16-QAM signal constellation
    
    
    % Calculate the SNR when the channel has an Eb/N0 = 10 dB.
    
    snr = EbNo + 10*log10(k) - 10*log10(nsmps);
    
    recSignal = awgn(Mdata,snr,'measured');
        
    recData = qamdemod(recSignal,M);
    
    dataOutMatrixG = de2bi(recData,k);
    out = dataOutMatrixG(:);   % Return data in column vector
    
    [numErrorsG,BER] = biterr(inputData,out);
    
    valus(count)=BER;
    count=count+1;
end
EbNo=0:step:max;
plot (EbNo,valus);
title('BER for 16-QAM')
xlabel('Eb/N0')
ylabel('BER')


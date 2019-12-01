
clear
clc
close all

M = 2;                     % Size of signal constellation
k = log2(M);                % Number of bits per symbol
n = 20000;                  % Number of bits to process
freq_sep=16;
nsamp = 5;    % Oversampling factor
Fs = 32;      % Sample rate (Hz)

max=20;
step=0.25;
size=max/step;
valus=zeros(1,size);
count=1;
for EbNo = 0:step:max
    
    inputData = randi([0 1],n,1);  % Generate vector of binary data
    inputsymbols = repelem(inputData,nsamp);
    % The results are complex column vectors whose values are elements of the 16-QAM signal constellation
    
    Mdata = fskmod(inputsymbols,M,freq_sep,nsamp,Fs);
    % Calculate the SNR when the channel has an Eb/N0 = 10 dB.
    
    snr = EbNo + 10*log10(k) - 10*log10(nsamp);
    
    recSignal = awgn(Mdata,snr,'measured');
    
    recData=fskdemod(recSignal,M,freq_sep,nsamp,Fs);
    dataOutMatrixG = de2bi(recData,k);
    out = dataOutMatrixG(:);   % Return data in column vector
    
    [numErrorsG,BER] = biterr(inputsymbols,out);%
    valus(count)=BER;
    count=count+1;
end
EbNo=0:step:max;
plot (EbNo,valus);
title('BER for BFSK')
xlabel('Eb/N0')
ylabel('BER')




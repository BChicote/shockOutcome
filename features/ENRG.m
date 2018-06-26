function ENRG = ENRG(s_in,fs)
%Feature from:
% "Prediction of countershock success using single features from multiple ventricular
% fibrillation frequency bands and feature combinations using neural networks"
% Andreas Neurauter et al., 2007;Resuscitation 73(2):253-263
%
% INPUT:
% - s_in: preprocessed ECG [mV]
% - fs: sampling frequency [sample/s]
% OUTPUT:
% - ENRG: energy [mV^2]. 
%
% DATE: 21/02/2017
% By Unai Irusta (unai.irusta@ehu.eus) and Beatriz Chicote(beatriz.chicote@ehu.eus)


% Fast Fourier Transform (FFT) with Hanning FFT window
win = hanning(length(s_in));
s_in_w = s_in.*win';
n = nextpow2(length(s_in));
% NFFT, number of poitns to represent the FFT .
NFFT = max(2^n,1024);
[P,f] = freqz(s_in_w,1,NFFT,fs);

X1 = abs(P);
S = X1.^2;
ENRG = sum(S)/NFFT;                      
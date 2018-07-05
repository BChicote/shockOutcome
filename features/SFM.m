function SFM = SFM(s_in,fs)
%Feature from:
% "Predicting outcome of defibrillation by spectral characterization and 
% nonparametric classification of ventricular fibrillation in patients with out-of-hospital cardiac arrest"
% Eftestol et al., 2000;Circulation 102(13):1523-1529
%
% INPUT:
% - s_in: preprocessed ECG [mV]
% - fs: sampling frequency [sample/s]
% OUTPUT:
% - SFM: spectral flatness measure. 
%
% DATE: 21/02/2017
% Implemented by Unai Irusta (unai.irusta@ehu.eus) and Beatriz Chicote(beatriz.chicote@ehu.eus)

% Fast Fourier Transform (FFT) with Hanning FFT window
win = hanning(length(s_in));
s_in_w = s_in.*win';
n = nextpow2(length(s_in));
% NFFT, number of poitns to represent the FFT .
NFFT = max(2^n,1024);
[X,f] = freqz(s_in_w,1,NFFT,fs);
P = abs(X).^2;

% SFM limited between 4 and 10Hz. 
f1=4; f2=10; % It is possible to change it.
K = length(f(f>f1&f<f2));
n = log(P(f>f1&f<f2))/K;
d = P(f>f1&f<f2)/K;

SFM =   K*prod(d.^(1/K))/sum(d);
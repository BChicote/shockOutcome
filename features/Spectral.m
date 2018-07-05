function [PF, CF, CP, MP, PSA] = Spectral(s_in,fs)
%Feature from:
% "Predicting outcome of defibrillation by spectral characterization and 
% nonparametric classification of ventricular fibrillation in patients with out-of-hospital cardiac arrest"
% Eftestol et al., 2000;Circulation 102(13):1523-1529
%
% "Prediction of countershock success using single features from multiple
% ventricular fibrillation frequency bands and feature combinations using
% neural networks" Neurauter et al.,2007;Resuscitation, vol. 73, no. 2, pp. 253–263. 
%
% INPUT:
% - s_in: preprocessed ECG [mV]
% - fs: sampling frequency [sample/s]
% OUTPUT:
% - PF: peak frequency[Hz].
% - CF: centroid frequency [Hz].
% - CP: centroid power [mV^2].
% - MP: max power [mV^2].
% - PSA: power spectrum analysis[mV^2 Hz].
%
%
% DATE: 21/02/2017
% By Beatriz Chicote(beatriz.chicote@ehu.eus) and Unai Irusta (unai.irusta@ehu.eus) 


% Fast Fourier Transform (FFT) with Hanning FFT window
win = hanning(length(s_in));
s_in_w = s_in.*win';
n = nextpow2(length(s_in));
% NFFT, number of poitns to represent the FFT .
NFFT = max(2^n,1024);
[X,f] = freqz(s_in_w,1,NFFT,fs);

P = abs(X).^2;
[~, idx] = max(P);
PF = f(idx);     
CF =sum(f.*P)/sum(P);   
CP = sum(P.^2)/(sum(P)*NFFT);  
MP = max(P);
PSA = sum(P.*f)/NFFT;     
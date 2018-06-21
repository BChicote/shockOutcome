function [SpeEnt] = SpeEnt(s_in,fs)
%Feature from:
% "Combining multiple ecg features does not improve prediction of defibrillation outcome
% compared to single features in a large population of out-of-hospital
% cardiac arrests" He et al., Critical Care, vol. 19, no. 1, p. 1, 2015.
%
% INPUT:
% - s_in: preprocessed ECG [mV]
% - fs: sampling frequency [sample/s]
% OUTPUT:
% - SpeEnt: Spectral Entropy.
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

% SpeEnt limited between 4 and 10Hz.  
f1=4; f2=10; % It is possible to change it.
K = length(f(f>f1&f<f2));
d = P(f>f1&f<f2)/K;

d = d/sum(d);   
SpeEnt = -sum(d.*log2(d))/log2(length(d));             
                                        % Dividing by log2(N)
                                        % is normalized to 0-1.
                                        % (maximum of Shann Ent).




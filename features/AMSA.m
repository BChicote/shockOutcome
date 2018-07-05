function AMSA = AMSA(s_in,fs)
%Feature from:
%"Amplitude spectrum area to guide defibrillation: A validation on 1617 patients with
% ventricular fibrillation." Ristagno, G. et al., 2015;Circulation 131, 478–487.
%
% INPUT:
% - s_in: preprocessed ECG [mV]
% - fs: sampling frequency [sample/s]
% OUTPUT:
% - AMSA: amplitude spectrum area(media ponderada en frecuencia de las amplitudes espectrales)[mV-Hz]. 
%
% DATE: 21/02/2017
% Implemented by Beatriz Chicote(beatriz.chicote@ehu.eus) and Unai Irusta (unai.irusta@ehu.eus)


% Fast Fourier Transform (FFT) with Tukey FFT window, according to Ristagno et al 2015
win = tukeywin(length(s_in));
s_in_w = s_in.*win';
n = nextpow2(length(s_in));
NFFT = max(2^n,1024);
[X,f] = freqz(s_in_w,1,NFFT,fs);
X = abs(X);

% AMSA calculation with a frequency range between 2-48Hz.
X = X(f>=2 & f<=48);
f = f(f>=2 & f<=48);
AMSA =  2*sum(X.*f)/NFFT;   %%% Normalization so |X| represents amplitudes                          
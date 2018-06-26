function LAC = LAC(s_in,fs)
%Feature from:
% "Logarithm of the absolute correlations of the ECG waveform estimates duration 
% of ventricular fibrillation and predicts successful defibrillation."
% Sherman et al., 2008; Resuscitation 78(3), 346–354.
%
% INPUT:
% - s_in: preprocessed ECG [mV]
% OUTPUT:
% - LAC: Logarithm of the absolute correlation of th ECG [sample/s]. 
%
% DATE: 21/02/2017
% Implemented by Unai Irusta (unai.irusta@ehu.eus) and Beatriz Chicote(beatriz.chicote@ehu.eus)

Nk = ceil(fs/2);  %%% Half a second
x = xcorr(s_in, Nk, 'unbiased');
LAC = log10(sum(abs(x(Nk+1:end))));

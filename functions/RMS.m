function RMS = RMS(s_in)
%Feature from:
% "Detrended fluctuation analysis predicts successful defibrillation for
% out-of-hospital ventricular fibrillation cardiac arrest" Lin et
% al.,Resuscitation 2010;81(3)297:301
%
% "Combining multiple ECG features does not improve prediction of defibrillation 
% outcome compared to single features in a large population of out-of-hospital cardiac arrests"
% He et al., Critical Care 2015;19(1):1.
%
% INPUT:
% - s_in: preprocessed ECG [mV]
% OUTPUT:
% - RMS(1): Root mean square value of the amplitude envelope of the signal
% - RMS(2): Root mean square value of the input signal, simply its std
%
% DATE: 21/02/2017
% Implemented by Unai Irusta (unai.irusta@ehu.eus) and Beatriz Chicote(beatriz.chicote@ehu.eus).

% According to Lin et al. (envelope of the input signal)
y_e = abs(hilbert(s_in));
RMS(1) = mean(y_e);
% According to He et al. (input signal)
RMS(2) = std(s_in); %%% Simply the RMS value of the input signal.






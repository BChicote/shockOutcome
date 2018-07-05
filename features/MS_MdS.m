function [MS MdS] = MS_MdS(s_in,fs)
%Feature from:
% "Prediction of countershock success using single features from multiple ventricular
% fibrillation frequency bands and feature combinations using neural networks"
% Andreas Neurauter et al., 2007;Resuscitation 73(2):253-263
%
% INPUT:
% - s_in: preprocessed ECG [mV]
% - fs: sampling frequency [sample/s]
% OUTPUT:
% - MS: mean slope [mV/s]. 
% - MdS: median slope [mV/s].
%
% DATE: 21/02/2017
% By Beatriz Chicote(beatriz.chicote@ehu.eus) and Unai Irusta (unai.irusta@ehu.eus).
d_s = diff(s_in);
MS  = fs*mean(abs(d_s));
MdS = fs*median(abs(d_s));
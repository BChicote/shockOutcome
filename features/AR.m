function AR = AR(s_in)
%Feature from:
% Implemented by Jekova et al. at "Defibrillation shock success estimation by a set of six 
% parameters derived from the electrocardiogram" Physiological measurement 20004;25(5):1179.
%
% INPUT:
% - s_in: preprocessed ECG [mV]
% OUTPUT:
% - AR: amplitude range[mV]. 
%
% DATE: 21/02/2017
% By Unai Irusta (unai.irusta@ehu.eus) and Beatriz Chicote(beatriz.chicote@ehu.eus)

AR = max(s_in)- min(s_in);
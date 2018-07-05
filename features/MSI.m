function MSI = MSI(s_in,fs)
%Feature from:
% "Predict Defibrillation Outcome Using Stepping Increment of 
% Poincare Plot for Out-of-Hospital Ventricular Fibrillation Cardiac Arrest"
% Gong, Yushun et al., BioMed research international 2015;2015
%
% INPUT:
% - s_in: preprocessed ECG [mV]
% - fs: sampling frequency [sample/s]
% OUTPUT:
% - MSI: median stepping increment. 
%
% DATE: 21/02/2017
% By Unai Irusta (unai.irusta@ehu.eus) and Beatriz Chicote(beatriz.chicote@ehu.eus) 

dif_1 = diff(s_in);
d1 = dif_1(1:end-1);
d2 = dif_1(2:end);
li = sqrt(d1.^2 + d2.^2)*fs;

MSI =  median(li);
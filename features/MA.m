function MA = MA(s_in)
%Feature from:
% Implemented by Brown et al. at "Signal analysis of the human
% electrocardiogram during ventricular fibrillation: frequency and
% amplitude parameters as predictors of successful countershock"
% Annals of emergency medicine, vol. 27, no. 2, pp. 184–188, 1996.
%
% "Predicting defibrillation success in sudden cardiac arrest
% patients" Firoozabadi et al., J Electrocardiol 2013;46(6):473–479.
%
% INPUT:
% - s_in: preprocessed ECG [mV]
% OUTPUT:
% - MA: mean amplitude [mV]. 
%
% DATE: 21/02/2017
% By Unai Irusta (unai.irusta@ehu.eus) and Beatriz Chicote(beatriz.chicote@ehu.eus) 

MA = mean(abs(s_in));
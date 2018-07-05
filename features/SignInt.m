function SignInt = SignInt(s_in)
%Feature from:
% "Signal integral for optimizing the timing of defibrillation."
% Xiaobo Wu et al., 2001; Resuscitation 84(12), 1704–1707.
%
% INPUT:
% - s_in: preprocessed ECG [mV]
% - fs: sampling frequency [sample/s]
% OUTPUT:
% - SignInt: Signal Integral [mV]. 
%
% DATE: 21/02/2017
% Implemented by  Beatriz Chicote(beatriz.chicote@ehu.eus) and Unai Irusta (unai.irusta@ehu.eus) 

SignInt = sum(abs(s_in));
   
    
                                        
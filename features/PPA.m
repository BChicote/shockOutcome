function PPA = PPA(s_in,fs)
%Feature from:
% "Predicting defibrillation success in sudden cardiac arrest
% patients" Firoozabadi et al., Journal of electrocardiology 2013;46(6):473–479.
%
% "Improving countershock success prediction during cardiopulmonary
% resuscitation using ventricular fibrillation features from higher ecg
% frequency bands" Neurauter el al., Resuscitation, vol. 79, no. 3, pp. 453–459, 2008.
%
% INPUT:
% - s_in: preprocessed ECG [mV]
% - fs: sampling frequency [sample/s]
% OUTPUT:
% - PPA: average peak to peak amplitude [mV]. 
%
% DATE: 21/02/2017
% By Unai Irusta (unai.irusta@ehu.eus) and Beatriz Chicote(beatriz.chicote@ehu.eus) 

    Ti = 0.1; % Mini intervals in which the signal is divided (s).
    N_ppa = floor(Ti*fs); % Number of samples for t=0.1s
    N = length(s_in);
    L = floor(N/N_ppa); %Number of intervals in which the signal is divided.
    val = zeros(1, L);
    % Maximum and minimum of each interval(25 samples in 0.1s)
    for i=1:L
        s_in_k = s_in(N_ppa*(i-1)+1:N_ppa*i);
        val(i)=max(s_in_k)-min(s_in_k);
    end

PPA = mean(val);
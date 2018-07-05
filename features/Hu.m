function [Hu] = Hu(s_in,T)
%Feature from:
% "Predicting defibrillation success by 'genetic' programming in patients 
% with out-of-hospital cardiac arrest" Podbregar et al., 2003; Resuscitation 57(2), 153–159.
% 
% "Evaluating rescaled range analysis for time series" Bassingthwaighte et
% al.,1994;Annals of biomedical engineering 22(4),432-444.
%
% INPUT:
% - s_in: preprocessed ECG [mV]
% - T: sampling frequency [sample/s]
% OUTPUT:
% - Hu: Hurst Exponent. 
%
% DATE: 21/02/2017
% Implemented by Beatriz Chicote(beatriz.chicote@ehu.eus) and Unai Irusta (unai.irusta@ehu.eus)


% Resample to next power of 2 larger than signal length
% We want to use scales of 4,8,16,....2^N (in nonoverlapping intervals up to L)

N    = nextpow2(length(s_in));
s_in = resample(s_in, 2^N, length(s_in));

n = 2.^(2:N);
R_S =zeros(1,length(n));

for i=1:length(n)
    y_int =reshape(s_in, n(i), length(s_in)/n(i));        
    ym = mean(y_int);
    ym = repmat(ym,n(i),1);
    yt = y_int-ym;
    zt = cumsum(yt);
    % R is the difference between the maximum and minimum values
    R = max(zt)-min(zt);
    % S is the local standard deviation
    S = std(y_int);
    R_S(i) = mean((R./S));
end

%%% Rescale time axis so duration is T
n = n/n(end)*T;
p = polyfit(log2(n), log2(R_S), 1);
Hu = p(1); % Hurst exponent is the slope of the linear fit of log-log plot
    
                                        
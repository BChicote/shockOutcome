function SNEO = SNEO(s_in,win,Nr)
%Feature from:
% "A New Interpretation of Nonlinear Energy Operator and Its Efficacy in
% Spike Detection" Mukhopadhyay et al.,1998; IEEE Transactions on
% Biomedical Engineering 45(2):180-187.
%
% "Smoothed nonlinear energy operator-based amplitude modulation features 
% for robust speech recognition"
% Alam, Md Jahangir et al., 2013; International Conference on Nonlinear
% Speech Processing 168-175
%
% "Nonlinear energy operators for defibrillation shock outcome prediction"
% Chicote el al.,2016; Computing in Cardiology Conference (CinC) 61-64
%
% INPUT:
% - s_in: preprocessed ECG [mV]
% - win:  type of window.
% - Nr :  window length.
% OUTPUT:
% - SNEO: Smoothed Non-linear Energy Operator. 
%
% DATE: 21/02/2017
% Implemented by Beatriz Chicote(beatriz.chicote@ehu.eus) and Unai Irusta (unai.irusta@ehu.eus) 


s_in = s_in(:);

% Delete n samples to the right and left
y = (s_in(Nr+1:end-Nr).^2) - ((s_in(1:end - (2*Nr))).*(s_in((2*Nr+1):end)));
y = conv(y, win);
y = y(Nr*2+1:end);
SNEO = median(y);
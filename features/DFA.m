function DFA = DFA(s_in,fs)
%Feature from:
%"Predicting defibrillation success by 'genetic' programming in patients 
% with out-of-hospital cardiac arrest"
% Podbregar et al., 2003; Resuscitation 57(2), 153–159.
%
% "Quantification of scaling exponents and crossover phenomena in 
% nonstationary heartbeat time series" Peng el al., 1995;Chaos: An Interdisciplinary Journal 
% of Nonlinear Science5(1),82-87.
%
% INPUT:
% - s_in: preprocessed ECG [mV]
% - fs: sampling frequency [sample/s]
% OUTPUT:
% - DFA : DFA(1) and DFA(2), two scaling exponents(slopes)of detrended fluctuation analysis(DFA).
%
% DATE: 21/02/2017
% Implemented by Unai Irusta (unai.irusta@ehu.eus) and Beatriz Chicote(beatriz.chicote@ehu.eus)

% Resample to next power of 2 larger than signal length
% We want to use scales of 4,8,16,....2^N (in nonoverlapping intervals up to L)
N    = nextpow2(length(s_in));
s_in = resample(s_in, 2^N, length(s_in));

% compute 
yk = cumsum(s_in-mean(s_in));

n = 2.^(2:N);
Fn = zeros(1,length(n));

for i = 1:length(n)
    y_int = reshape(yk, n(i), length(s_in)/n(i));             % Intervals in columns
    n_int = reshape(0:length(yk)-1, n(i), length(yk)/n(i)); % Same thing x axis
    
    yn = zeros(1,length(yk));
    for j = 1:length(yk)/n(i)
        p = polyfit(n_int(:,j), y_int(:,j), 1);
        yn((j-1)*n(i)+1:j*n(i)) = polyval(p,n_int(:,j));
    end
    Fn(i) = sqrt(sum((yk-yn).^2));
end
Fn = Fn/sqrt(length(yk));

%%% Acording to Lian et al 2010 DFA1 for scales 2-6, and DFA2 for scales 6-11
p = polyfit(log10(n(1:5)), log10(Fn(1:5)),1);   %%% n(1)=2^2, n(5)=2^6
DFA(1) = p(1); 
p = polyfit(log10(n(5:10)), log10(Fn(5:10)),1);   %%% n(5)=2^6, n(10)=2^11
DFA(2) = p(1);                                   
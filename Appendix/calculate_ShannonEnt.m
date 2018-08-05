function [ShannEnt] = calculate_ShannonEnt(s_in,N_bin)
%Feature from:
% "Combining multiple ecg features does not improve prediction of defibrillation outcome
% compared to single features in a large population of out-of-hospital
% cardiac arrests" He et al., Critical Care, vol. 19, no. 1, p. 1, 2015.
%
% INPUT:
% - s_in: preprocessed ECG [mV]
% - N_bin: number of bins to estimate PDF
% OUTPUT:
% - ShannEnt: Shannon Entropy.
%
% DATE: 28/07/2017
% Implemented by Beatriz Chicote(beatriz.chicote@ehu.eus) and Unai Irusta (unai.irusta@ehu.eus)

if nargin < 2
    N_bin = 30;
end

%%% Estimate PDF by bin counts
p = histcounts(s_in, N_bin)/length(s_in);
p(p==0)=[];   %%% Remove 0 counts to avoid NaN

%%% Compute shannon entropy
ShannEnt = -sum(p.*log2(p))/log2(length(p));
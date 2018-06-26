function FuzzyEn= FuzzyEn(s_in,m,r,n)
%Feature from:
% "Characterization of surface EMG signal based on fuzzy entropy"
% Chen et al.2007; IEEE Transactions on neural systems and rehabilitation
% engineering 15(2):266-272.
%
% We implemented the definition presented in:
% "Measuring complexity using FuzzyEn, ApEn, and SampEn" 
% Chen et al.2009; Medical Engineering \& Physics 31(1):61-68.
%
% with similarity function exp(-(dij/r)^n)
%
% INPUT:
% - s_in: input time series
% - m: maximum template length
% - r:  matching tolerance [mV]
% - n : the step of the fuzzy exponential function
% OUTPUT:
% - FuzzyEn: Fuzzy Entropy.
%
%
% DATE: 21/02/2018
% Original code by Unai Irusta (unai.irusta@ehu.eus) and Beatriz Chicote (beatriz.chicote@ehu.eus)

N = length(s_in);
phi = zeros(2,1);
%%% Do it for m and m+1
for i = 1:2
    %%% Create vectors
    l = m + i - 1;  %%% l=m (i=1), l=m+1 (i=2)
    x = zeros(N-m, l);
    for j = 1:N-m
        x(j,:) = s_in(j:j+l-1)-mean(s_in(j:j+l-1));
    end
    %%% Compute distances
    %%% Start in j+1 , x(j+1:end,:), to avoid self counts
    %%% Run to N-m and use that dij=dji to reduce comp time
    for j = 1:N-m-1
        %%% m = 1 is a special case cause all vectors are 0 (subtract mean)
        if l == 1
            d = zeros(N-m,1);
        else
            d = max(abs(x(j+1:end,:)-repmat(x(j,:),N-m-j,1))');
        end
        phi(i) = phi(i)+sum(exp(-(d/r).^n));
    end
end
FuzzyEn = log(phi(1)/phi(2));

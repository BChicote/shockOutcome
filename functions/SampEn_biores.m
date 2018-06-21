function SampEn = SampEn_biores(s_in,m,r)
% Sample Entropy from Richman and Moormam
% Physiological time series analysis using approximate entropy and sample
% entropy. Am J Physio Hear Circ Physiol. 2000
%
% INPUT:
% - s_in: input time series
% - m: maximum template length
% - r:  matching tolerance [mV]
% - n : the step of the fuzzy exponential function
% OUTPUT:
% - SampEn: Sample Entropy.
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
        x(j,:) = s_in(j:j+l-1);
    end
    %%% Compute distances
    %%% Start in j+1 avoid self counts
    %%% Run to N-m and use that the count is simmetrical (ij and ji) to reduce comp time
    for j = 1:N-m-1
        if l==1
            d = abs(x(j+1:end,:)-repmat(x(j,:),N-m-j,1))';
        else
            d = max(abs(x(j+1:end,:)-repmat(x(j,:),N-m-j,1))');
        end
        phi(i) = phi(i)+sum(d<=r);
    end
end
SampEn = log(phi(1)/phi(2));

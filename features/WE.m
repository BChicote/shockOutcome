function  WE = WE(data,W_NAME,MAX_LVL)
%Feature from:
% "Wavelet entropy: a new tool for analysis of short duration brain electrical signals."
% Rosso, Osvaldo A et al., 2001; Journal of neuroscience methods 105(1), 65–75.
%
% INPUT:
% - s_in: preprocessed ECG [mV]
% - W_NAME: name of the wavelet transform 
% - MAX_LVL: maximum decomposition level of the wavelet transform
% OUTPUT:
% - WE: wavelet entropy
%
% Implemented by : Pouya Bashivan ( pbshivan@memphis.edu) according by
% Rosso et al. 
% Date :Dec 2014.
% Updated by Unai Irusta (unai.irusta@ehu.eus) and Beatriz Chicote(beatriz.chicote@ehu.eus)

[C, L] = wavedec(data, MAX_LVL, W_NAME);
for k = 1 : MAX_LVL
    if k < MAX_LVL
        D(k).values = detcoef(C, L, k);
    else
        D(k).values = detcoef(C, L, k);
        D(k+1).values = appcoef(C, L, W_NAME, k);
    end
end

for k = 1 : MAX_LVL+1
    E(k) = sum(D(k).values .^ 2) / size(D(k).values, 2);
end

P = E ./ sum(E);
WE = -sum(P .* log(P));                                        
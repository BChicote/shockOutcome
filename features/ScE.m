function ScE = ScE(s_in)
%Feature from:
% "Scaling exponent predicts defibrillation success 
% for out-of-hospital ventricular fibrillation cardiac arrest."
% Callaway et al., 2001; Circulation 103(12), 1656–1661.
%
% INPUT:
% - s_in: preprocessed ECG [mV]
% OUTPUT:
% - ScE: Scaling Exponent. 
%
% DATE: 21/02/2017
% Implemented by Unai Irusta (unai.irusta@ehu.eus) and Beatriz Chicote(beatriz.chicote@ehu.eus) 

 % Signal to column vector
    x = s_in(:);
    
    N = length(x);
    k_max = 1200;
    L = zeros(1,k_max);
    % Calculation of L(k)
    for k = 1:k_max
        l = [];
        for m = 1:k
            y = x(m:k:end);
            y = diff(y);
            % It is necessary 0.025 to raise the values in low k's.
            l(m) = sum(max(abs(y),0.025))/(N-k);
        end
        L(k)=N*mean(l); %%% According by Sherman 2008, L(k)=k^(1-D)
    end

    % Calculation of SCE
    % To find flatness, we find between k=5 y K =25
    % Least squares adjustment arround to the place of smaller slope 
    K = 2;
    SS = (log10(L(K+1:23))-log10(L(K+3:25)))./(-log10(K+1:23)+log10(K+3:25));
    [~, pos]=min(SS); pos = pos+K+1;
    p = polyfit(log10(pos-K:pos+K), log10(L(pos-K:pos+K)),1);
    ScE = 1-p(1);
   
    
                                        
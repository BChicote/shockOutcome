function computeFeatures
% Function to compute all features from BBDD data
% It computes features for the full interval 5-sec analysis window
% DATE: 05/03/2018
% Implemented by Unai Irusta (unai.irusta@ehu.eus) and Beatriz Chicote(beatriz.chicote@ehu.eus)

%%%% General definitions (data, scripts)
appDirName  = fileparts(mfilename('fullpath'));
addpath(genpath(fullfile(appDirName,'features')));

%%%% Load the data
load(fullfile(appDirName,'BBDD'));

%%%% Shock outcome prediction feature names
par_name = {'AR', 'MA', 'PPA', 'MSI', 'SigInt', 'RMS_Li', 'RMS_He', 'SNEO', 'ENRG','MS', 'MdS',...
    'AMSA', 'PF', 'CF','CP', 'MP', 'PSA', 'SFM','SpecEnt', 'SampEn', 'FuzzEn', 'WE', 'ScE','Hu', 'DFA1', 'DFA2', 'LAC'};
N_par = length(par_name);  %%% Number of features

% Define output variables, saved in .mat for postprocessing
X   = zeros(length(data), N_par);

%%% Sampling frequencies
fs  = 250;
fsd = 60; %%% For FuzzEn/SampEn

%%% preprocessing filter
order = 4;
fc = [0.5 30];
[b,a]= ellip(order,1, 30, 2*fc/fs);

for i=1:length(data)
    fprintf('Computing features for ECG %3d of %3d\n', i, length(data));
    
    %%% Retreive the ECG data
    s_ecg = data(i).s_ecg;

    %%% Preprocess ECG and resample to fsd=60Hz (SampEn/FuzzEn), leave 2-sec to avoid transients of filter
    s_ecg   = [ones(1,2*fs)*s_ecg(1) s_ecg(:)' ones(1,2*fs)*s_ecg(end)];
    s_ecg   = filter(b,a,s_ecg);
    s_ecgd  = resample(s_ecg, fsd, fs);
    s_ecg   = s_ecg(2*fs+1:end-2*fs);
    s_ecgd  = s_ecgd(2*fsd+1:end-2*fsd);
    
    % Compute Features (Feature calculation scripts under functions)
    
    % Time domain features 
    X(i,1)  = AR(s_ecg);    
    X(i,2)  = MA(s_ecg);
    X(i,3)  = PPA(s_ecg,fs);
    
    % MSI, SigInt, LAC are time domain features. LAC autocorrelation
    X(i,4) = MSI(s_ecg,fs);
    X(i,5) = SignInt(s_ecg);

    %% Amplitude of the envelope: different definitions Lin et al 2010, He et al 2015
    X(i,6:7) = RMS(s_ecg);
    
    %% Energy related features
    Nr = 8; win = kaiser(Nr*4+1,9);
    X(i,8) = SNEO(s_ecg,win,Nr);
    X(i,9) = ENRG(s_ecg,fs);   %%% Energy in the frequency domain

    % Slope domain features: how output of function is defined
    [X(i,10), X(i,11)] = MS_MdS(s_ecg,fs);
    
    % Frecuency domain features: how output of function is defined.
    X(i,12)    = AMSA(s_ecg,fs);
    [X(i,13), X(i,14), X(i,15), X(i,16), X(i,17)] = Spectral(s_ecg,fs); % Spectral(PF,CF,CP,MP,PSA)
    
    % Features measuring signal complexity/regularity
    X(i,18) = SFM(s_ecg,fs);
    X(i,19) = SpeEnt(s_ecg,fs);
    
    % Entropies: for sample and fuzzy entropy use fs=60Hz
    %%%% Optimal values for SampEn/FuzzEn 
    %%%% As described in Chicote et al 2016 (Entropy paper)
    X(i,20) = SampEn(s_ecgd,1,0.05);
    X(i,21) = FuzzyEn(s_ecgd,3,0.08,2);
    X(i,22) = WE(s_ecg,'db1',4);

    % Other non-linear features
    X(i,23) = ScE(s_ecg);
    X(i,24) = Hu(s_ecg,length(s_ecg)/fs);   %%% HURST EXP need to know duration of signal in sec
    X(i,25:26) = DFA(s_ecg,fs);   
    
    X(i,27) = LAC(s_ecg,fs);
    
end

%%% Save results
save(fullfile(appDirName, 'Results'), 'X','par_name');

rmpath(genpath(fullfile(appDirName,'features')));
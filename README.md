# shockOutcome
Code for computing shock outcome prediction features using an example database.


This repository is structured the following way:

The main script computeFeatures.m  loads the database BBDD.mat and computes the shock outcome prediction features.

The database BBDD.mat contains 6 cases of out of hospital cardiac arrest patients with a 5 s preshock segment of the ECG signal.

The functions folder contains a .m file to each feature, which are called from the main script.

The appendix folder contains the .m files to perform the supplementary analysis explained in the supplementary materias of: "Fuzzy and Sample Entropies as Predictors of Patient Survival Using Short Ventricular Fibrillation Recordings During Out of Hospital Cardiac Arrest", Entropy 2018

If you use this code on your work please cite the following paper, thank you.

Chicote et al. "Fuzzy and Sample Entropies as Predictors of Patient Survival Using Short Ventricular Fibrillation Recordings During Out of Hospital Cardiac Arrest", Entropy 2018

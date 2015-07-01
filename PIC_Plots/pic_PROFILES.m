% post processing of electron velocity distribution function, to get a phase-resolved optical emission spectrum

clear all
close all
clc

%input parameter
ne=5e9; % cm^-3
Te=10;  % eV
Ti_Te=0.005; % Ti/Te
pressure=30; % Pa
folder='../runsARGON30Pa200V0.03m_AVERTESTLONGv2';

s_ind=18000;
f_ind=19999;

% loading of density,potential and temperature files
% L=XloadFiles(folder);
L=19999;
nof=L;

% averaged densities Ar+, e- and potential
Xaverprofil(folder,s_ind,f_ind,nof,Te,ne)
% profil of densities (Ar+, e-) and potential
Xdevprofil(folder,nof,Te,ne)
% temperature
XaverTemp(folder,Te,s_ind,f_ind,nof)

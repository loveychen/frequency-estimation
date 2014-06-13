function [cos_DFT_Vin,sin_DFT_Vin] = recdft(Vin,inputN)

% SYNTAX -----------------------------------------------------
%       [cos_DFT_Vin,sin_DFT_Vin]= recdft(Vin,Nc)
% where
%       Vin    = input 3 phase signal whose amplitude is required   
%       inputN = number of sample points over which DFT is taken
% The file to be loaded has to be in the same directory as main.m
%
% Author:   Sandesh Gandhi
%           c/o Power Anser Labs, IIT Bombay
% Updated : 10th MAY 2008
%------------------------------------------------------------
%% Initialisations
global inputvolt_length;global F0;global Fs;global N;
cos_DFT_Vin=zeros(3,inputvolt_length);
sin_DFT_Vin=zeros(3,inputvolt_length);
%amplitude_Vin=zeros(3,inputvolt_length);
%% Finding |magnitude| by DFT

    k=[1:inputN;1:inputN;1:inputN]; % column
    cos_DFT_Vin(:,1) = 2/inputN*sum(cos(2*pi/N*(k-1)).*Vin(:,1:inputN),2);
    sin_DFT_Vin(:,1) = 2/inputN*sum(sin(2*pi/N*(k-1)).*Vin(:,1:inputN),2);
% the above for loop however calculates DFT only for one window.
    for win=1:(inputvolt_length-inputN),
    cos_DFT_Vin(:,win+1)=cos_DFT_Vin(:,win)+...
               2/inputN*(Vin(:,win+inputN)-Vin(:,win))*cos(2*pi/N*(win-1));
    sin_DFT_Vin(:,win+1)=sin_DFT_Vin(:,win)+...
               2/inputN*(Vin(:,win+inputN)-Vin(:,win))*sin(2*pi/N*(win-1));
    end
%-----------------------------------------code checked till here

% |Vm| and |Fm| can be calculated here itself
%amplitude_Vin=(sqrt((cos_DFT_Vin).^2+(sin_DFT_Vin).^2));

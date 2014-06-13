function [V_pos,V_mag]= seqcomp(Vin)
% SYNTAX -------------------------------------------------------
% example
%            [V_pos,V_mag] = seqcomp(Vin);
%  where              Vin  = input sampled 3 phase voltage (row vector)

% The file to be loaded has to be in the same directory as main.m
% Author:   Sandesh Gandhi
%           c/o Power Anser Labs, IIT Bombay
%           Date : 8th Sept. 2007
%----------------------------------------------------------------
% PI=3.14159265;
%% Note: This will work only if 2nd phase lags the 1st phase
global inputvolt_length;
a=exp(j*2*pi/3);
 matA=[ 1     a      a^2  ;
        a^2   1        a  ;
        a     a^2      1 ];
 V_pos=ones(3,inputvolt_length);
 V_mag=ones(1,inputvolt_length);
%for k=1:inputvolt_length
 V_pos= 1/3*matA*Vin;
%end
 V_mag=sqrt((1/3)*(sum(V_pos.*conj(V_pos),1)));
 
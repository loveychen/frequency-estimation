function [delta_f,flag]= deltafreq(Fm,Vm,Vin,Avg_in,inputvolt_length,Vrms,Fs)


% SYNTAX -----------------------------------------------------
%      [system_freq]= deltafreq(Fm,Vm,inputvolt_length)
% where
%              Fm  = amplitude average of 3 phases 
%              Vm  = amplitude voltage of 3 phases 
% inputvolt_length = length of input signal       

% For example:
% [system_freq]= findfreq(Fm,Vm,inputvolt_length)
% The file to be loaded has to be in the same directory as main.m
%
% Author:   Sandesh Gandhi
%           c/o Power Anser Labs, IIT Bombay
%           Date : 8th Sept. 2007
%-------------------------------------------------------------   
%% Schmidt trigger
F0=50;
N=Fs/F0;
delta_f=zeros(1,inputvolt_length-2*N);
system_freq=zeros(1,inputvolt_length-2*N);
flag=zeros(1,inputvolt_length-2*N);
flag(1)=-1;
p=2;
for n=2:inputvolt_length-2*N,
   if( Vin(p,n)>Vrms | Vin(p,n)< (-Vrms))
 % if( Vin(1,n)>Vrms)
        if(Vin(p,n)*Avg_in(p,n)>0)
            flag(n)=1;
        else
            flag(n)=-1;
        end
    else
        flag(n)=flag(n-1);        
    end
     delta_f(n) = flag(n)*(Fm(n)*F0)/(Vm(n)+Fm(n));
     
end

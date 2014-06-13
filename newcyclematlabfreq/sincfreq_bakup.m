function [delta_freq,flag]= sincfreq(Fm,Vm,sinctable,freqtable,mid,Vin,Avg_in,inputvolt_length,Vrms,Fs)
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
F0 = 50;
N=Fs/F0;
delta_freq=zeros(1,inputvolt_length);
flag=zeros(1,inputvolt_length);
flag(1)=1;

len=length(sinctable);
Inew=0;Iprev=0;Ishift=0;
low=0;
high=len;
range=low+1:high;

p=2;                %  2nd phase
for n=2:inputvolt_length,
    
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
   
   
   if(Vm(n)>0)
        ratio=Fm(n)/Vm(n);
        if(ratio<0.0001)
            sys_freq=F0;
        else
            Inew=binsearch(sinctable,(-1)*flag(n)*ratio);
            Inew=Inew;%+low;
            %Ishift=Inew-Iprev;
            sys_freq=freqtable(Inew);
            %Iprev=Inew;
%               if(Inew > 1001 & Inew < (len-1001))
%                   if(n<N)  
%                     low  =Inew-1000;
%                     high =Inew+1000;
%                     range=low:high;
%                   else
%                   range=range+Ishift;
%                   end
%               else
%                   range=1:len;
%               end
        end
         delta_freq(n)=sys_freq-F0;
    else
       delta_freq(n)=delta_freq(n-1);
    end
    
end
    
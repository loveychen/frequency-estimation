function [zcd_freq]= zcdfreq(Vk)
% SYNTAX -------------------------------------------------------
%       [zcd_freq]= zcdfreq(Vk);
% where       Vk   = input sampled 3 phase voltage
%
% Author  : Sandesh Gandhi & Chetan Tonde
%           c/o Power Anser Labs, IIT Bombay and Electrical Dept., 
%           College of Engineering Pune.
% Updated : 10th MAY 2008
%----------------------------------------------------------------
global inputvolt_length;global F0;global Fs;global time_stamp;

zcd_freq=zeros(1,inputvolt_length)+F0;
zerocross_new=0;
zerocross_old=0;
phase=2;% 2nd phase is used to calculate freq.
k=1;

while(Vk(phase,k)>0)
    k=k+1;
end
while(Vk(phase,k)<0)
    k=k+1;
end
for (n=k:inputvolt_length)
    if ( Vk(phase,n-1)<0 & Vk(phase,n)>0 )
    zerocross_new=time_stamp(n-1) - 1/Fs* Vk(phase,n-1)/( Vk(phase,n)-Vk(phase,n-1) );
    time_interval = zerocross_new-zerocross_old;
    zcd_freq(n)=1/time_interval;
      if (zcd_freq(n)>74) 
      zcd_freq(n)=F0;
      end
    zerocross_old=zerocross_new;
    else
    zcd_freq(n)=zcd_freq(n-1);   
           
        
    end
  %  zcd_freqavg(n)=((n-1)*zcd_freq(n-1)+zcd_freq(n))/n;
end


function [avgfreq]= avgvalue(freq,Nc)
% SYNTAX -------------------------------------------------------
%       [avgfreq] = avgvalue(Vk,inputvolt_length,N,cycles)
%             Nc  = avg is to be taken over Nc number of samples 
%
% Author:   Sandesh Gandhi
%           c/o Power Anser Labs, IIT Bombay
%           Updated: 26th Dec. 2007
%----------------------------------------------------------------
global inputvolt_length;global F0;global Fs;global time_stamp;global Vmax;
[ph len]=size(freq);
avgfreq=zeros(ph,len);
allNc = 1:Nc+1;
bag=0;
prevfreq=(sum(freq(allNc)))/(Nc+1);
for p=1:ph % for 3 phases    
    for i=1:len-Nc,
        if( rem(i,Nc+1)  )
            avgfreq(p,i)=prevfreq;
        else
            avgfreq(p,i)=prevfreq;
            prevfreq=(sum(freq(i-1+allNc)))/(Nc+1);
        end
        
    end
    
end

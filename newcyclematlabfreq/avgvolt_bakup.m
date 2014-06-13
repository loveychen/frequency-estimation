function [Avg_volt,N]= avgvolt(Vk,inputvolt_length,N,cycles)
% SYNTAX -------------------------------------------------------
%       [Avg_volt] = inputvolt(Vk,inputvolt_length,N,cycles)
% where       Vk   = input sampled 3 phase voltage
% inputvolt_length = length of input signal
%              N   = samples per period
%         cycles   = number of cycles over avg is to be taken
% For example:
% [Avg_volt]= avgvolt(Vk,inputvolt_length,50,1)
% [Avg_volt] = inputvolt(Vk,inputvolt_length)
% cycles=1 and N=50 is assumed
% The file to be loaded has to be in the same directory as main.m
%
% Author:   Sandesh Gandhi
%           c/o Power Anser Labs, IIT Bombay
%           Date : 8th Sept. 2007
%----------------------------------------------------------------

N=N*cycles;% very important !!!
[ph len]=size(Vk);
Avg_volt=zeros(ph,inputvolt_length);

for p=1:ph % for 3 phases
    k=2:N+1;
    Avg_volt(p,1)= (1/N)*(0.5)*sum((Vk(p,k)+ Vk(p,k-1)));
    %this will give average of the first window
%avg of successive windows are found recursively 
    for k=(N+2):(inputvolt_length) 
    Avg_volt(p,k-N) = Avg_volt(p,k-N-1)+ ...
    (1/N)*0.5*((Vk(p,k)+ Vk(p,k-1))-(Vk(p,k-N)+Vk(p,k-N-1))); 
    end 
 
end

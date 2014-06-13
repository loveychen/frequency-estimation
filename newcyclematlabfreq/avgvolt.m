function [Avg_volt]= avgvolt(Vk,inputN)
% SYNTAX -------------------------------------------------------
%       [Avg_volt] = avgvolt(Vk,inputN)
% where       Vk   = input sampled voltage
%         inputN   = moving average over inputN samples
% Author:   Sandesh Gandhi
%           c/o Power Anser Labs, IIT Bombay
%   Updated         : 10th MAY 2008
%----------------------------------------------------------------
[ph len]=size(Vk);
Avg_volt=zeros(ph,len);
q = 2:inputN+1;
for p=1:ph % for 3 phases    
    Avg_volt(p,1)= (1/inputN)*(0.5)*sum((Vk(p,q)+ Vk(p,q-1)));
    %this will give average of the first window
    %avg of successive windows are found recursively     
  for k=(inputN+2):(len),
  Avg_volt(p,k-inputN) = Avg_volt(p,k-inputN-1)+...
  (1/inputN)*0.5*((Vk(p,k)+ Vk(p,k-1))-(Vk(p,k-inputN)+Vk(p,k-inputN-1))); 
  end 
end

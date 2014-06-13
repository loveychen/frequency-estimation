function [kVk_pos]= newkval(newVk_pos)
% SYNTAX -------------------------------------------------------
%       [k] =kval(newVk_pos);
% where       Vk   = positive seq voltage

% Author :  Sandesh Gandhi
%           c/o Power Anser Labs, IIT Bombay
% Updated:  10th MAY 2008
%----------------------------------------------------------------

%% Generate the complex voltage signal 
global inputvolt_length;global F0;global Fs;global N;
a=exp(j*2*pi/3);
kVk_pos= zeros(3,inputvolt_length);
%theta  =zeros(ph,inputvolt_length);
%% MY SIGNAL
%   Vk(1,:)= Vmax*(sin(w*k));
%   Vk(2,:)= Vmax*(sin(w*k-2*pi/3));
%   Vk(3,:)= Vmax*(sin(w*k+2*pi/3));

%kVk_pos(1,:)=(1/3)*(1*Vk(1,:)  + a*Vk(2,:)    +a^2*Vk(3,:));
%kVk_pos(2,:)=(1/3)*(a^2*Vk(1,:)+ 1*Vk(2,:)    +  a*Vk(3,:));
%kVk_pos(3,:)=(1/3)*(a*Vk(1,:)  + a^2*Vk(2,:)  +  1*Vk(3,:));
%kVk_pos(1,:)=Vk(1,:)+j*Vk(1,:);
for p=1:3,
    for n = N+1:inputvolt_length,
kVk_pos(p,n-N)=(newVk_pos(p,n-N)*conj(newVk_pos(p,n)))*exp(j*2*pi*F0/Fs*n);
    end
end

kVk_pos(2,:)=(a^2)*kVk_pos(2,:);
kVk_pos(3,:)=(a)*kVk_pos(3,:);
% kVk_pos = imag(kVk_pos);
% myplotgraph(kVk_pos,31);

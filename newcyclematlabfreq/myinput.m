function [Vk]= myinput(F)
% SYNTAX -------------------------------------------------------
%       [Vk] =myinput(48);
% where       Vk   = input sampled 3 phase voltage
%
% Author  : Sandesh Gandhi & Chetan Tonde
%           c/o Power Anser Labs, IIT Bombay and Electrical Dept., 
%           College of Engineering Pune.
% Updated : 10th MAY 2008
%----------------------------------------------------------------
global inputvolt_length;global F0;global Fs;global time_stamp;global Vmax;
W=2*pi*F;
w=2*pi*F/Fs;
dt=1/Fs;

V=zeros(3,length(time_stamp));
V(1,:)= Vmax*(sin(W*time_stamp));
V(2,:)= Vmax*(sin(W*time_stamp-2*pi/3));
V(3,:)= Vmax*(sin(W*time_stamp+2*pi/3));
% plot(time_stamp,V(1,:)','r');
% hold on;plot(time_stamp,V(2,:)','y');
% hold on;plot(time_stamp,V(3,:)','b');
% grid on;
Vmax
Vk=zeros(3,inputvolt_length);
k=1:inputvolt_length;
Vk(1,:)= Vmax*(sin(w*k));
Vk(2,:)= Vmax*(sin(w*k-2*pi/3));
Vk(3,:)= Vmax*(sin(w*k+2*pi/3));
freq(1:inputvolt_length)=F;
myplotgraph(freq,6,'k--');

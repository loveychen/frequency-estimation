 function [Vk]= inputvolt(filename)

% SYNTAX -----------------------------------------------------
% [Vk]= inputvolt(filename)
% the name of the file should be in single quotation marks

% For example: 
% [Vin] = inputvolt('rybdata/data1415-1550.adf');

% Author:   Sandesh Gandhi
%           c/o Power Anser Labs, IIT Bombay
%   Updated         : 10th MAY 2008
%-------------------------------------------------------------

% Modify this file depending upon the input data
global Vschmitt;
global inputvolt_length;global F0;global Fs;global time_stamp;global Vmax;
usedata=load(filename);
inputvolt_length=length(usedata);
Vk=zeros(3,inputvolt_length);
%Vt=zeros(3,inputvolt_length);
time_stamp=(1:inputvolt_length)/Fs;

Vk(1,:)=transpose(usedata(:,1));
Vk(2,:)=transpose(usedata(:,3));
Vk(3,:)=transpose(usedata(:,2));
% 
 Vk(1,:)=(Vk(1,:)-1.432)*238.8873;
 Vk(2,:)=(Vk(2,:)-1.45)*238.8873;
 Vk(3,:)=(Vk(3,:)-1.485)*238.8873;
% 
%       Vk(1,:)=(Vk(1,:)-1.45)*238.8873;
%       Vk(2,:)=(Vk(2,:)-1.45)*238.8873;
%       Vk(3,:)=(Vk(3,:)-1.45)*238.8873;

% 
 figure(1);plot(time_stamp,Vk(1,:),'r');
 hold on;plot(time_stamp,Vk(2,:),'y');
 hold on;plot(time_stamp,Vk(3,:),'b');
 title('Original input 3 phase voltage vs time');
 grid on;

Vschmitt=175;% to be Calibrated accurately for Schmidt Trigger 



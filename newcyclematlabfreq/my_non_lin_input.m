%function [Vk,inputvolt_length,N,Fs,Vrms,time_stamp]= my_non_lin_input()
%% Description: Generates sampled 3 phase varying frequency input.
% SYNTAX -------------------------------------------------------
% Author:   Sandesh Gandhi & Chetan Tonde
%           c/o Power Anser Labs, IIT Bombay
%           Date : 3rd December 2007
%----------------------------------------------------------------

Vmax=300
Vschmitt=270

F0=50;
N=50;                       % samples per cycle
Fs=F0*N;                    % sampling frequency ( Samples/sec )
 
inputvolt_length=30000;     % 12  secs
first_threshold=10000;    
ft=first_threshold/Fs       % 4th sec
second_threshold=20000;
st=second_threshold/Fs      % 8th sec
time_stamp=(1:inputvolt_length)/Fs;
t=zeros(1,second_threshold-first_threshold);
w=zeros(1,second_threshold-first_threshold);

% t=time_stamp(first_threshold:second_threshold);
% win =2*pi*(48 + (ft-4).*(ft-6).*(ft-7.5))/Fs; % starting frequency (Hz) 
% w   =2*pi*(48 + (t-4).*(t-6).*(t-7.5))/Fs;
% wout=2*pi*(48 + (st-4).*(st-6).*(st-7.5))/Fs; % ending frequency (Hz) 

% win=2*pi*(48 + (ft-4).*(ft-6).*(ft-7.5))/Fs; % starting frequency (Hz) 
% 
% t=time_stamp(first_threshold:second_threshold);
% w=2*pi/Fs*(48 + (t-4).*(t-6).*(t-7.5));
% wout=2*pi*(48 + (st-4).*(st-6).*(st-7.5))/Fs; % ending frequency (Hz) 
% t=time_stamp(first_threshold+1:second_threshold);
win =2*pi/Fs*(48 + (ft-5)*(ft-7)); % starting frequency (Hz) 
w   =2*pi/Fs*(48 + (t-5).*(t-7));
wout=2*pi/Fs*(48 + (st-5).*(st-7)); % ending frequency (Hz) 

Vk=zeros(3,inputvolt_length);
omega=zeros(1,inputvolt_length);

for n=1:inputvolt_length     
    if(n<=first_threshold)        
    
        Vk(1,n)= Vmax*(sin(win*n));
        Vk(2,n)= Vmax*(sin(win*n-2*pi/3));
        Vk(3,n)= Vmax*(sin(win*n+2*pi/3));
        omega(n)=win;
    elseif (n>first_threshold & n<=second_threshold)
        Vk(1,n)= Vmax*(sin(w(n-first_threshold)*n));
        Vk(2,n)= Vmax*(sin(w(n-first_threshold)*n-2*pi/3));
        Vk(3,n)= Vmax*(sin(w(n-first_threshold)*n+2*pi/3));
        omega(n)=w(n-first_threshold);
        
    else         %(n>second_threshold & n<inputvolt_length)
        Vk(1,n)= Vmax*(sin(wout*n));
        Vk(2,n)= Vmax*(sin(wout*n-2*pi/3));
        Vk(3,n)= Vmax*(sin(wout*n+2*pi/3));
        omega(n)=wout;
    end
    
end    

figure(1);h=plot(time_stamp,(omega*Fs/(2*pi))');
title('Frequency variation');
disp('Saving figure 1...frequency plot');
saveas(h,'data/mykinputfreq.fig');
saveas(h,'data/mykinputfreq.eps');
%[h]=myplotgraph(omega*Fs/(2*pi),6,'c');


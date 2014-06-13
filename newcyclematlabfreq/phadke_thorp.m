function [pfreq]= phadke_thorp(Vk_pos)

% The file to be loaded has to be in the same directory as main.m
%
% Author:   Sandesh Gandhi
%           c/o Power Anser Labs, IIT Bombay
% Updated: 10th MAY 2008
%-------------------------------------------------------------
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The observation here is that the angle values are the same for all three 
% phases. Hence, any one (here R phase ) is selected
global inputvolt_length;global F0;global Fs;global N;
pfreq=zeros(1,inputvolt_length)+F0;
phase=zeros(1,inputvolt_length);
phase_diff=zeros(1,inputvolt_length-1);
p=2;
phase=angle(Vk_pos(p,:));

for n=2:inputvolt_length,
       phase_diff(n-1)=phase(n)-phase(n-1);
       if (abs(phase_diff(n-1))>pi)
            if (phase_diff(n-1))<0 %+-
            phase_diff(n-1)= phase_diff(n-1)+2*pi;
            elseif (phase_diff(n-1))>0    %-+
            phase_diff(n-1)=phase_diff(n-1)-2*pi;
            end
        end
end

count=1;
bag = phase_diff(1);

for ArrayNum=1:(inputvolt_length-2)
    if ((bag >= 0.5)  | (bag <= -0.5))        
            pdelta_f=bag*F0*N/(count*2*pi);
            pfreq(ArrayNum)= F0 + pdelta_f;    
            bag=bag+phase_diff(ArrayNum+1);
            count=count+1;
        while((bag >= 0.5)  | (bag <= -0.5))    
        bag=bag-phase_diff(ArrayNum+1-count+1);
        count=count-1;
        end
    else
        if(ArrayNum>=2 & count~=0)
            pdelta_f=bag*F0*N/(count*2*pi);
            pfreq(ArrayNum)= F0 + pdelta_f;  
            % pfreq(ArrayNum)= pfreq(ArrayNum-1);
        end
        bag=bag+phase_diff(ArrayNum+1);
        count=count+1;
    end

end   





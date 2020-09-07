% A simple script demonstrating the use of smooth-filtering with different options 
%   in order to perfrom denoising of a respiratory signal. Both the noisy and the original version are given.
%   We 'quantify' the performance of different options based on RelError:  ||reconstructed-original||/||original||  
% -it loosely relates to problem 4.24
%  you may experiment by altering the window (or span) parameter in the smooth command (currently set at 11) 

close all; clear all;load Resp_noise1, 
time=[1:numel(resp)]*(1/fs);

% original & noisy respiratory signal
subplot(3,2,1),plot(time,resp_noise1,'k',time,resp,'b'),xlabel('time(s)'),legend('noisy','original')
RelErrror=norm(resp_noise1-resp)/norm(resp); text(0.2,1.2,num2str(RelErrror))

filtered=smooth(resp_noise1,11);  %standard moving-average filter  
subplot(3,2,2),plot(time,filtered,'r',time,resp,'b'),xlabel('time(s)'),legend('restored','original'),title('moving average')
RelErrror=norm(filtered'-resp)/norm(resp); text(0.2,1.2,num2str(RelErrror))

filtered_loess=smooth(resp_noise1,11,'loess');% loess (quadratic fit with span of 11 samples) 
subplot(3,2,3),plot(time,filtered_loess,'r',time,resp,'b'),xlabel('time(s)'),legend('restored','original')
title('loess (quadratic fit)'),RelErrror=norm(filtered_loess'-resp)/norm(resp); text(0.2,1.2,num2str(RelErrror))

filtered_lowess=smooth(resp_noise1,11,'lowess'); % linear fit with span of 11 samples 
subplot(3,2,4),plot(time,filtered_lowess,'r',time,resp,'b'),xlabel('time(s)'),legend('restored','original')
title('lowess (linear fit)'),RelErrror=norm(filtered_lowess'-resp)/norm(resp); text(0.2,1.2,num2str(RelErrror))

filtered_sgolay=smooth(resp_noise1,11,'sgolay',1);% Savitzky-Golay of order1 and span of 11 samples
subplot(3,2,5),plot(time,filtered_sgolay,'r',time,resp,'b'),xlabel('time(s)'),legend('restored','original')
title('Savitzky-Golay:order1'),RelErrror=norm(filtered_sgolay'-resp)/norm(resp); text(0.2,1.2,num2str(RelErrror))

filtered_sgolay2=smooth(resp_noise1,11,'sgolay',3); % Savitzky-Golay of order3 and span of 11 samples
subplot(3,2,6),plot(time,filtered_sgolay2,'r',time,resp,'b'),xlabel('time(s)'),legend('restored','original')
title('Savitzky-Golay:order3'),RelErrror=norm(filtered_sgolay2'-resp)/norm(resp); text(0.2,1.2,num2str(RelErrror))


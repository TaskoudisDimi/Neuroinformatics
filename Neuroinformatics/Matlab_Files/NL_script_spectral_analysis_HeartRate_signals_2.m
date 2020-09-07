% script demonstrating spectral analysis of HeartRate signal before and  during meditation
% Important Notice: the HR-signals are not  uniformly sampled --> therefore FFT is not applicable 
% -it relates to example 3-6

clear all, close all;
load Hr_pre,fs=1; ts=1/fs;

timeaxis=[ceil(t_pre(1)):ts:floor(t_pre(end))]; % form a reqular time-axis (equally spaced time intervals) 
hr_pre_interpolated=interp1(t_pre,hr_pre,timeaxis); % using the given time-signal pairs ''predict'' the signal at timeaxis  
                                                      %check : find(isnan(hr_pre_interpolated))
subplot(2,2,1),plot(t_pre,hr_pre,'.',timeaxis,hr_pre_interpolated),xlim([t_pre(1),t_pre(end)])
legend('orginal','interpolated'),title('before meditation'),xlabel('time(sec)')

WINDOW=256;NOVERLAP=200;NFFT=256;[pxx,faxis] = pwelch(detrend(hr_pre_interpolated),WINDOW,NOVERLAP,NFFT,fs,'onesided'); % Note: detrend is necessary
subplot(2,2,3),plot(faxis,pxx),xlabel('f (Hz)'),ylabel('PSD'),xlim([0 1]),title('Welch-based PSD')


load Hr_med,timeaxis_med=[ceil(t_med(1)):ts:floor(t_med(end))];
hr_med_interpolated=interp1(t_med,hr_med,timeaxis_med); % check : find(isnan(hr_med_interpolated))
subplot(2,2,2),plot(t_med,hr_med,'.',timeaxis_med,hr_med_interpolated),xlim([t_med(1),t_med(end)])
legend('orginal','interpolated'),title('during meditation'),xlabel('time(sec)')

WINDOW=256;NOVERLAP=200;NFFT=256;[pxx,faxis] = pwelch(detrend(hr_med_interpolated),WINDOW,NOVERLAP,NFFT,fs,'onesided');
subplot(2,2,4),plot(faxis,pxx),xlabel('f (Hz)'),ylabel('PSD'),xlim([0 1]),title('Welch-based PSD')

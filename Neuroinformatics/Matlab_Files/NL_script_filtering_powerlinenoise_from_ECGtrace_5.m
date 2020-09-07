% A simple script demonstrating the use of notch-filter 
%             so as to suppress power-line noise 60 HZ  in ECGtrace   
% -it relates to problem 4.19

close all; clear all;
load ECG_60Hz_data, Fs=250
time=[1:numel(x)]*(1/Fs);

subplot(3,1,1),plot(time,x),xlabel('Time(s)'),grid,title('original ECG trace')

% design an stop-band FIR 36-order filter for removing powerline nosie @ 60 Hz 
b=fir1(32,[58 62]/(Fs/2),'stop'); %try to increase the order of the filter and the option "bandpass"
filtered_x=filtfilt(b,1,x); % apply the filter in zero-phase mode 
subplot(3,1,2),plot(time,filtered_x),grid,title('FIR stopband-filtered signal')


% design an stop-band IIR 3-order filter for removing powerline nosie @ 60 Hz 
[b,a]=butter(3,[58 62]/(Fs/2),'stop');
filtered_x=filtfilt(b,a,x); % apply the filter in zero-phase (bidirectional) mode 
subplot(3,1,3),plot(time,filtered_x),grid,title('butterworth IIR stopband-filtered signal')


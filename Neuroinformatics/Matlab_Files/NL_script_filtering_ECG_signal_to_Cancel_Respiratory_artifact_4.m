% script that relates to problem 4.14
 %it demonstrates the use of high-pass filtering to suppress noise that
 %contaminates ECG-trace and relates to respiration artifact 

%close all; clear all;
load ECG_9, Fs=250

subplot(3,1,1),plot([1:numel(x)]*(1/Fs),x),xlabel('Time(s)'),grid,title('original ECG trace')

% design an a high-pass FIR 32-order dilter with cutoff at 8 Hz 
b=fir1(12,8/(Fs/2),'high');
filtered_x1=filter(b,1,x); % apply the filter in causal (forward-direction) mode 

subplot(3,1,2),plot([1:numel(x)]*(1/Fs),filtered_x1),grid,title('high-bass filtered signal : causal-filtering')

filtered_x2=filtfilt(b,1,x); % apply the filter in zero-phase mode (i.e. bidirectionally) 
subplot(3,1,3),plot([1:numel(x)]*(1/Fs),filtered_x2),grid,title('high-bass filtered signal : bidirectional-filtering')
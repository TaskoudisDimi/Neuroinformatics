% script demonstrating the analysis of high-resolution ECG for detecting late-potentials  
% (fs = 2210 Hz).   
% the ECG-trace has a very slow component that needs to be removed before the QRS-detection
% after removing the very-slow component the R-peaks are detected and the
% ECG-trace is segmented into beats that are then averaged to procude the ''correct'' signal.  


clear all;close all;
x=load('ECGtest.csv');           % Load the test signal
fs = 2210;                       % Sampling Frequency

t=[1:numel(x)]; %dicrete_time #samples
%time=[1:numel(x)]*(1/fs); % time in sec
figure(1),clf,subplot(2,2,1),plot(t,x,t,smooth(x,2051)+0.5),legend('original ECG-trace','very-slow component'),xlabel('sample no'),xlim([0,23000])
subplot(2,2,3),plot(t,x-smooth(x,2051)),hold on,title('trace minus the very slow component'),xlabel('sample no'),xlim([0,23000])


% detecting the R-peak based on the denoised -trace
x2=x-smooth(x,2051);[PKS,LOCS]=findpeaks(x2,t,'minpeakheight',0.3,'MinPeakDistance',100);
plot(LOCS,PKS,'ro'),hold

% segmenting around the QRS complex
ECG_traces=[]; for i=1:numel(LOCS)
              segment=x2(LOCS(i)-500:LOCS(i)+1500)';  
              ECG_traces(i,:)=segment;end 
    
subplot(1,2,2),strips(ECG_traces'),title('heart-beat segments'),grid  

figure(2),clf,
time=[1:size(ECG_traces,2)]*(1/fs);
plot(time,ECG_traces+0.5,time,mean(ECG_traces),'k'),xlabel('time(s)'),legend('individual segments','Signal-Averaged')




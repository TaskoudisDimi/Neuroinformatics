% script exemplifying the feature extraction step for a Heart Rate Signal  
%  having prototypical-signals for heart rate before(HR_pre) and during meditation
%  we can ''classify'' an unknown signal based on simple statistical characteristics  
%
clear all; close all;
load HR_unknown, load HR_pre, load HR_med
figure(1),clf
subplot(3,2,1),plot([1:numel(hr_pre)],hr_pre,'r'),title('before meditation'),ylabel('beats/min'),
subplot(3,2,3),plot([1:numel(hr_med)],hr_med,'g'),title('during meditation'),ylabel('beats/min'),
subplot(3,2,5),plot([1:numel(hr_unknown)],hr_unknown,'b'),title('unknown state'),ylabel('beats/min'),xlabel('time')

%%%%%%%% extracting statistical features 
Features_pre=[median(hr_pre),std(hr_pre),skewness(hr_pre)]
Features_med=[median(hr_med),std(hr_med),skewness(hr_med)]
Features_unknown=[median(hr_unknown),std(hr_unknown),skewness(hr_unknown)]

subplot(1,2,2),plot3(Features_pre(:,1),Features_pre(:,2),Features_pre(:,3),'ro',Features_med(:,1),Features_med(:,2),Features_med(:,3),'g*'...
   ,Features_unknown(:,1),Features_unknown(:,2),Features_unknown(:,3),'bsquare','markersize',10 ),grid
legend('before','during','unknown'),xlabel('mean'),ylabel('std'),zlabel('skewness')
title('feature-space'),axis square

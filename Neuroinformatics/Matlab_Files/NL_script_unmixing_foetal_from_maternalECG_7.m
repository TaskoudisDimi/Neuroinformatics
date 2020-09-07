% This script demonstrates the use of (two different algorithms of) ICA
% for isolating maternal from foetal cardiac signal   
% First the Jade's algorithm is invoked 
% and then the FASTICA toolbox is utilized (from command line mode)
% Note: you should add to the path the foetal_ecg_ica_example

clear all, close all
X=load('FOETAL_ECG.dat');
time=X(:,1)' ; ECGdata=X(:,2:9)';

B=jadeR(ECGdata); % deriving the unmixing-matrix
Sources=B*ECGdata; % estimating the ICs (source-signal)
subplot(1,2,1),strips(zscore(ECGdata')),grid,title('original traces'),xlabel('time')
subplot(1,2,2),strips(zscore(Sources')),grid,title('estimated source-signals'),xlabel('time')

display('selecting the 1st and 7th ICs from the JADE-ICA method')
figure,plot(time,zscore(Sources(1,:)),time,zscore(Sources(7,:))+6),grid,xlabel('time'),legend('1st','7th')
title('selected ICs from JADE-ICA method')



% PART-II using FAST-ICA toolbox
% you need to set FASTICA_toolbox in the path
[sources] = fastica (ECGdata,'numOfIC', 3);  %  [icasig] = fastica (ECGdata, 'lastEig', 5, 'numOfIC', 3);
figure,subplot(1,2,1),strips(zscore(ECGdata')),grid,title('original traces'),xlabel('time')
subplot(1,2,2),strips(zscore(sources')),grid,title('FASTICA based estimated source-signals'),xlabel('time')


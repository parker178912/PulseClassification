% Main pulse classification script
%
%%%%%%%%%%%%%%%%%%

clear all
clc

Tainan_data = importdata('2001_0614_023525_TAP020.txt');

disp('Starting computations');
dt = Tainan_data(2,1) - Tainan_data(1,1);
A1 = Tainan_data(:,3);
A2 = Tainan_data(:,4);

signal1 = cumsum(A1)' .* dt .* 981; % convert acc (in g) to velocity (in cm/s)
signal2 = cumsum(A2)' .* dt .* 981; % convert acc (in g) to velocity (in cm/s)

% setup wavelet analysis
wname = 'db4';
TpMin = 0.25;
TpMax = 15;
numScales = 50;
scaleMin = floor(TpMin/1.4/dt);
scaleStep = ceil((TpMax/1.4/dt - scaleMin)/numScales);
scaleMax = scaleMin + numScales*scaleStep;
scales = scaleMin:scaleStep:scaleMax;

% Perform continuous wavelet transform on both components
coefs1 = cont_wavelet_trans(signal1, dt, scales, wname);
coefs2 = cont_wavelet_trans(signal2, dt, scales, wname);


maxCoefs = (coefs1.^2 + coefs2.^2).^0.5;

%pulse extraction
maxCoef = max(max(maxCoefs));
col = find(max(maxCoefs) == maxCoef);
row = find(max(maxCoefs,[],2) == maxCoef);
maxDir = atan(coefs2(row,col)/coefs1(row,col));
signal = signal1*cos(maxDir(1))+signal2*sin(maxDir(1));
pulse_data = analyze_record(signal,dt,col,row,scales,wname); % classify the pulse.
pulseScale = scales(row);
    
% record the data about the extracted pulse
pulseData = pulse_data;
rotAngles = maxDir;
selectedCol = col;
selectedRow = row;
    
% block out the region surrounding the extracted pulse so that pulse from a different time - freq region is selected
blockMin = col-10/25*pulseScale;
blockMax = col+10/25*pulseScale;
idx = find(([1:length(signal1)] > blockMin).*([1:length(signal1)] < blockMax) == 1);
maxCoefs(:,idx) = 0;

fn = './classification_result.mat';
save(fn,'pulseData','rotAngles','selectedCol','selectedRow');

Ipulse = find_Ipulse(pulseData);
Tp = find_Tp(pulseData);
make_plot(pulseData);
pulse_data.pulse_indicator


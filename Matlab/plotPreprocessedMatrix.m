% with PCA
f12_desk = load('C:\research\scn-lab\preprocessingfNIRS\Matlab\data\PreProcessedFiles\testdata\sum_f12_desk\_subj1_preprocessed.mat');
f12_desk_og = load('C:\research\scn-lab\preprocessingfNIRS\Matlab\data\PreProcessedFiles\testdata\sum_f12_desk\_subj1.mat');
f12_laptop = load('C:\research\scn-lab\preprocessingfNIRS\Matlab\data\PreProcessedFiles\testdata\sum_f12_laptop\_subj1_preprocessed.mat');
f12_laptop_og = load('C:\research\scn-lab\preprocessingfNIRS\Matlab\data\PreProcessedFiles\testdata\sum_f12_laptop\_subj1.mat');
f13_laptop = load('C:\research\scn-lab\preprocessingfNIRS\Matlab\data\PreProcessedFiles\testdata\sum_f13_laptop\_subj1_preprocessed.mat');
f13_laptop_og = load('C:\research\scn-lab\preprocessingfNIRS\Matlab\data\PreProcessedFiles\testdata\sum_f13_laptop\_subj1.mat');

% without PCA
f12_desk_diff = load('C:\research\scn-lab\preprocessingfNIRS\Matlab\data\PreProcessedFiles\sum_f12_desk\_subj1_preprocessed.mat');

%f14_desk = load('C:\research\scn-lab\preprocessingfNIRS\Matlab\data\PreProcessedFiles\testdata\sum_f14_desk\_subj1_preprocessed.mat');
%f14_desk_og = load('C:\research\scn-lab\preprocessingfNIRS\Matlab\data\PreProcessedFiles\testdata\sum_f14_desk\_subj1.mat');
%f14_laptop = load('C:\research\scn-lab\preprocessingfNIRS\Matlab\data\PreProcessedFiles\testdata\sum_f14_laptop\_subj1_preprocessed.mat');
%f14_laptop_og = load('C:\research\scn-lab\preprocessingfNIRS\Matlab\data\PreProcessedFiles\testdata\sum_f14_laptop\_subj1.mat');
%f15_desk = load('C:\research\scn-lab\preprocessingfNIRS\Matlab\data\PreProcessedFiles\testdata\sum_f15_desk\_subj1_preprocessed.mat');
%f15_desk_og = load('C:\research\scn-lab\preprocessingfNIRS\Matlab\data\PreProcessedFiles\testdata\sum_f15_desk\_subj1.mat');

% DEFINE CONSTANTS
channel = 15; % select channel(s) to display
range = 500:1000 % select range of timepoints to display
medianFilterConstant = 20; % define neighborhood size for median filtering

% LOAD DATA
withPCA = f12_desk.oxy1(range,channel);
withoutPCA = f12_desk_diff.oxy1(range,channel);

% APPLY MEDIAN FILTERING (spike removal)
%withPCA = medfilt1(withPCA, medianFilterConstant);
withoutPCA = medfilt1(withoutPCA, medianFilterConstant);

% Z-SCORE
withPCA = zscore(withPCA);
withoutPCA = zscore(withoutPCA);

plot(f12_desk_og.t(range), [withPCA, withoutPCA])
legend('with PCA', 'w/o PCA');
corrcoef(withPCA, withoutPCA)

%plot(f12_laptop_og.t, f12_laptop.oxy1(:,channel))
%plot(f13_laptop_og.t, f13_laptop.oxy1(:,channel))

%plot(f14_desk_og.t, f14_desk.oxy1(:,channel))
%plot(f14_laptop_og.t, f14_laptop.oxy1(:,channel))
%plot(f15_desk_og.t, f15_desk.oxy1(:,channel))

%plot(f12_desk_og.t, f12_desk.oxy1)
%plot(f12_laptop_og.t, f12_laptop.oxy1)
%plot(f13_laptop_og.t, f13_laptop.oxy1)

%plot(f14_desk_og.t, f14_desk.oxy1)
%plot(f14_laptop_og.t, f14_laptop.oxy1)
%plot(f15_desk_og.t, f15_desk.oxy1)


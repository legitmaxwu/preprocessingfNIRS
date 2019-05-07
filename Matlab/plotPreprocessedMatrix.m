%--------------------------------
%
% BEFORE RUNNING THIS SCRIPT
% 1. Create a directory called 'data' in the 'Matlab' folder.
% 2. Put all the data folders ("sum_f12_desk", etc.) into the 'data'
%    folder.
%
% FILEPATH SELECTION POPUPS
% First popup: select 'Matlab/data/'
% Second popup: select 'Matlab/data/sum_f12_desk/...probeInfo.mat'
%
%--------------------------------

%-------------------------------
% VARIABLES TO EDIT
    processLength = 3;              % NUMBER OF SAMPLES to process in preprocessingfNIRS
    sampleName = 'sum_f12_desk';    % NAME OF SAMPLE FOLDER to use
    useSubjNumber = 1;              % use subject 1 or 2
    
    channel = 15; % select RANGE OF CHANNELS to display
    range = 2000:2500; % select RANGE OF TIMEPOINTS to display
    medianFilterConstant = 20; % define NEIGHBORHOOD SIZE for median filtering
%-------------------------------


%------------------------------
% PREPROCESSING SCRIPT
% This function call generates 2 folders: 
%   - 'Matlab/data/PreprocessedFiles/withPCA/'
%   - 'Matlab/data/PreprocessedFiles/withoutPCA'
% with all of the preprocessed data. Each piece of data has 2 copies: one
% processed with PCA and one without. They are placed in the corresponding
% folders.
%
% NOTE: Once you preprocess the data once, the 'preprocessingfNIRS()' line
%       can be commented out!
% NOTE: If you want to change the number of samples processed in
%       preprocessing fNIRS, you want to delete the 'withPCA' and 'withoutPCA'
%       folders and regenerate all the data.
    preprocessingfNIRS('sum_', 1, processLength);
%-------------------------------

if ~exist(rawdir)
    rawdir=uigetdir('','Choose MATLAB Directory');
end

% PUT PATH TO PCA
PCApath = strcat(rawdir,'\data\PreProcessedFiles\withPCA\');
NoPCApath = strcat(rawdir,'\data\PreProcessedFiles\withoutPCA\');

PCAdir = dir(PCApath);
noPCAdir = dir(NoPCApath);

if useSubjNumber == 1
    matrixFilename = '_subj1.mat';
else
    matrixFilename = '_subj2.mat';
end

samplePathPCA = strcat(PCApath,sampleName,'\',matrixFilename);
samplePathNoPCA = strcat(NoPCApath,sampleName,'\',matrixFilename);
PCAmatrix = load(samplePathPCA);
noPCAmatrix = load(samplePathNoPCA);

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

leg = legend(strcat(sampleName,', ',matrixFilename,', with PCA'), strcat(sampleName,', ',matrixFilename,', w/o PCA'));
set(leg,'Interpreter', 'none');

% DISPLAY CORRELATION COEFFICIENTS
correlationCoefficients = corrcoef(withPCA, withoutPCA)


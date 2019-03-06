function extractTimePoints( dataprefix )
%EXTRACTTIMEPOINTS Summary of this function goes here
%   Detailed explanation goes here

rawdir=uigetdir('','Choose Data Directory');
currdir=dir(strcat(rawdir,filesep,dataprefix,'*'));
if length(currdir)<1
    error(['ERROR: No data files found with ',dataprefix,' prefix']);
end

[matfile, matpath] = uigetfile('*.mat','Choose fNIRS Matrix File');
load(fullfile(matpath, matfile));
if ~exist('t','var')
    error('ERROR: Invalid probeInfo file (does not contain a t object');
end
if ~exist('t','var')
    error('ERROR: Invalid probeInfo file (does not contain a s object');
end

timePoints = ones(23, 1);
for i=1:length(currdir)
    subj=currdir(i).name;
    header=regexprep(currdir(i).name,'^sum_[fsu]*','');
    header=regexprep(header,'_.*$','');
    header=str2num(regexprep(header,'^0',''));
    subjdir=dir(strcat(rawdir,filesep,subj,filesep,dataprefix,'*'));
    if isempty(subjdir) || ~isdir(strcat(rawdir,filesep,subj,filesep,subjdir(1).name))
        subjfolder = strcat(rawdir,filesep,subj);
        outpath = strcat(rawdir,filesep,'TimePoints',filesep,subj);
        matFile = dir(strcat(subjfolder,'/',strcat('_subj1.mat')));
        matFileName = matFile.name;
        mat=load(strcat(subjfolder,'/',matFileName));
        tp = zeros(23,1);
        tp(1,1) = header;
        counter=2;
        for j=1:size(mat.s, 1)
            if mat.s(j,1) == 1
                tp(counter,1)=mat.t(1,j);
                counter=counter+1;
            end
        end
        timePoints = [timePoints tp];
        save(strcat(rawdir,filesep,'timePoints.mat'), 'timePoints');
    end
end


end


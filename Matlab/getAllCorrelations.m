function [ output_args ] = getAllCorrelations( input_args )
%GETALLCORRELATIONS Summary of this function goes here
%   Detailed explanation goes here

numChannels = 44;

rawdir = 'data/PreProcessedFiles/';

% skipped f13, s11
samples = {'f12', 'f14', 'f15', 's09', 's10', 's12', 's13', 's14', 's15', 's16', 'su09', 'su10', 'su11', 'su12', 'su13', 'su14', 'su15', 'su16'};

matrix = zeros(size(samples, 2), numChannels, 6);

for i = 1:size(samples, 2)
    for channel = 1:numChannels
        i
        channel
        matrix(i, channel, :) = getCorrelations(samples{i}, channel);
    end
end

save(strcat(rawdir, 'correlationData.mat','matrix'));



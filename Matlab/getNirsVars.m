%-----------------------------------------------
%step 3 - convert to nirs format
%-----------------------------------------------
function [SD, aux, t] = getNirsVars(d, sd_ind, samprate, wavelengths, probeInfo)
    nSrcs = probeInfo.probes.nSource0;
    nDets = probeInfo.probes.nDetector0;
    numchannels = probeInfo.probes.nChannel0;
    MeasList = [probeInfo.probes.index_c ones(numchannels,1)];
    WavelengthColumn = ones(numchannels,1);
    MeasList1 = [MeasList WavelengthColumn];
    WavelengthColumn(:)=2;
    MeasList2 = [MeasList WavelengthColumn];
    SD.MeasList = [MeasList1; MeasList2];
    SD.Lambda = wavelengths;
    SD.SrcPos = probeInfo.probes.coords_s3;
    SD.nSrcs = nSrcs;
    SD.SrcAmp = ones(nSrcs,1);
    SD.DetPos = probeInfo.probes.coords_d3;
    SD.nDets = nDets;
    SD.DetAmp = ones(nDets,1);
    SD.SpatialUnit = 'cm';
    aux = zeros(length(d),8);
    t = 0:1/samprate:length(d)/samprate - 1/samprate;
end
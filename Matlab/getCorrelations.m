function [ correlations ] = getCorrelations( sampleID, channel )

% sampleID: f[HR] if data was collected on Friday
%           s[HR] if data was collected on Saturday
%           su[HR] if data was collected on Sunday
%
% [HR] = military time, 2 digits
% i.e. Saturday 1:00pm --> s13
% i.e. Sunday 9:00am --> su09

rawdir = 'data/PreProcessedFiles/';

dir1 = strcat(rawdir, 'sum_', sampleID, '_laptop');
dir2 = strcat(rawdir, 'sum_', sampleID, '_desk');

desk1 = matfile(strcat(dir2, '/', '_subj1_preprocessed.mat'));
desk2 = matfile(strcat(dir2, '/', '_subj2_preprocessed.mat'));
lptp1 = matfile(strcat(dir1, '/', '_subj1_preprocessed.mat'));
lptp2 = matfile(strcat(dir1, '/', '_subj2_preprocessed.mat'));

subj1 = desk1.deoxy1(100:5000,channel); 
subj1 = subj1';

subj2 = desk2.deoxy2(100:5000,channel); 
subj2 = subj2';

subj3 = lptp1.deoxy1(100:5000,channel); 
subj3 = subj3';

subj4 = lptp2.deoxy2(100:5000,channel); 
subj4 = subj4';

x = [100:5000]; 
x = x;

% figure;

% plot(x,[subj1;subj2;subj3;subj4])

% title('straightup')

% legend('subj1','subj2','subj3','subj4')

% xlabel('time')

 

z_subj1 = zscore(subj1);
z_subj2 = zscore(subj2);
z_subj3 = zscore(subj3);
z_subj4 = zscore(subj4);

% figure;
% 
% plot(x,[z_subj1;z_subj2;z_subj3;z_subj4]);
% title('z-scored')
% legend('z_subj1','z_subj2','z_subj3','z_subj4')
% xlabel('time')

z_subj1=z_subj1';
z_subj2=z_subj2';
z_subj3=z_subj3';
z_subj4=z_subj4';

s01vs02 = corr(z_subj1,z_subj2, 'rows', 'complete');

correlations(1,1) = s01vs02;

s01vs03 = corr(z_subj1,z_subj3, 'rows', 'complete');

correlations(1,2) = s01vs03;

s01vs04 = corr(z_subj1,z_subj4, 'rows', 'complete');

correlations(1,3) = s01vs04;

s02vs03 = corr(z_subj2,z_subj3, 'rows', 'complete');

correlations(1,4) = s02vs03;

s02vs04 = corr(z_subj2,z_subj4, 'rows', 'complete');

correlations(1,5) = s02vs04;

s03vs04 = corr(z_subj3,z_subj4, 'rows', 'complete');

correlations(1,6) = s03vs04;

% uncutAverage = mean(correlations)
% 
% z_subj1=z_subj1';
% 
% z_subj2=z_subj2';
% 
% z_subj3=z_subj3';
% 
% z_subj4=z_subj4';
% 
%  
% 
%  
% 
% %cut everything that's +/2 1SD
% 
%  
% 
% for i = 21:length(z_subj1);
%     if z_subj1(1,i) > 2 | z_subj1(1,i) < -2;
%         z_subj1(1,i-20:i+20) = NaN;
%     end
% end
% 
% for i = 21:length(z_subj2);
%     if z_subj2(1,i) > 2 | z_subj2(1,i) < -2;
%         z_subj2(1,i-20:i+20) = NaN;
%     end
% end
% 
% for i = 21:length(z_subj3);
%     if z_subj3(1,i) > 2 | z_subj3(1,i) < -2;
%         z_subj3(1,i-20:i+20) = NaN;
%     end
% end
% 
% for i = 21:length(z_subj4);
%     if z_subj4(1,i) > 2 | z_subj4(1,i) < -2;
%         z_subj4(1,i-20:i+20) = NaN;
%     end
% end
% 
% z_subj1 = z_subj1(1,1:4901);
% z_subj2 = z_subj2(1,1:4901);
% z_subj3 = z_subj3(1,1:4901);
% z_subj4 = z_subj4(1,1:4901);
% 
% figure;
% plot(x,[z_subj1;z_subj2;z_subj3;z_subj4]);
% title('despiked')
% legend('z_subj1','z_subj2','z_subj3','z_subj4')
% xlabel('time')
% 
% z_subj1=z_subj1';
% z_subj2=z_subj2';
% z_subj3=z_subj3';
% z_subj4=z_subj4';
% 
% s01vs02 = corr(z_subj1,z_subj2, 'rows', 'complete');
% cut_correlations(1,1) = s01vs02;
% 
% s01vs03 = corr(z_subj1,z_subj3, 'rows', 'complete');
% cut_correlations(1,2) = s01vs03;
% 
% s01vs04 = corr(z_subj1,z_subj4, 'rows', 'complete');
% cut_correlations(1,3) = s01vs04;
% 
% s02vs03 = corr(z_subj2,z_subj3, 'rows', 'complete');
% cut_correlations(1,4) = s02vs03;
% 
% s02vs04 = corr(z_subj2,z_subj4, 'rows', 'complete');
% cut_correlations(1,5) = s02vs04;
% 
% s03vs04 = corr(z_subj3,z_subj4, 'rows', 'complete');
% cut_correlations(1,6) = s03vs04;
% 
% cut_correlations
% cutAverage = mean(cut_correlations)

% save('correlations.mat','correlations','-v7.3', '-append');

% save('thresh2SDcorrelations.mat','cut_correlations','-v7.3', '-append');

end


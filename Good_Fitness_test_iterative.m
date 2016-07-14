
%Script to analyze several fitness test of normality
clear 
%Loading the specific dataset
load('12960CellImages_WithOutliers_140Sel_LauraP_paper.mat')

% A good example of normal distribution is the feature 4 (C_kurtoPgra_cel)
% only for LLC

%% Preparating the data

% Nfeat = 4;

for Nfeat = 1:20

idx = inputTable.identidad == 'LLC'; %For only an identity
pfeature = inputTable{idx,Nfeat+8}; %Particular feature
% pfeature = inputTable{:,Nfeat+8}; %Particular feature

% figure, histfit(pfeature,64), title( [inputTable.Properties.VariableNames{Nfeat+8} ...
%     ' histogram with superimposed fitted normal density'], 'Interpreter', 'none' )
% xlim([-10 30]) 

% [h,p] = chi2gof(pfeature,'Nbins', 20, 'Alpha',0.05)


[h(Nfeat),p(Nfeat)] = adtest(pfeature, 'Alpha', 0.05);

end

table(inputTable.Properties.VariableNames( (1:20) + 8 )', uint8(h'),p',...
    'VariableNames', {'Feature', 'h', 'p'})

%Script to analyze several fitness test of normality
clear 
%Loading the specific dataset
load('12960CellImages_WithOutliers_140Sel_LauraP_paper.mat')

% A good example of normal distribution is the feature 4 (C_kurtoPgra_cel)
% only for LLC

%% Preparating the data

Nfeat = 4;
idx = inputTable.identidad == 'LLC'; %For only an identity
% pfeature = inputTable{idx,Nfeat+8}; %Particular feature

figure, histfit(pfeature,64), title( [inputTable.Properties.VariableNames{Nfeat+8} ...
    ' histogram with superimposed fitted normal density'], 'Interpreter', 'none' )
% xlim([-10 30]) 
%% One-sample Kolmogorov-Smirnov test
% h = kstest(x) returns a test decision for the null hypothesis that the data
% in vector x comes from a *standard normal distribution* , against the alternative
% that it does not come from such a distribution, using the one-sample 
% Kolmogorov-Smirnov test. The result h is 1 if the test rejects the null
% hypothesis at the 5% significance level, or 0 otherwise.

% Plotting both cdf
figure
x = (pfeature-mean(pfeature))/std(pfeature);
[f,x_values] = ecdf(x);
F = plot(x_values,f);
set(F,'LineWidth',2);
hold on;
G = plot(x_values,normcdf(x_values,0,1),'r-');
set(G,'LineWidth',2);
legend([F G],...
       'Empirical CDF','Standard Normal CDF',...
       'Location','SE');
hold off

[h,p] = kstest(x, 'Alpha', 0.05)

% h =1, p = 0, It rejects the null hypothesis. 

% p-value of the test, returned as a scalar value in the range [0,1].
% p is the probability of observing a test statistic as extreme as, 
% or more extreme than, the observed value under the null hypothesis.
% Small values of p cast doubt on the validity of the null hypothesis.

%% Chi-square goodness-of-fit test
% h = chi2gof(x) returns a test decision for the null hypothesis that the
% data in vector x comes from a normal distribution with a mean and variance
% estimated from x, using the chi-square goodness-of-fit test. The alternative
% hypothesis is that the data does not come from such a distribution. 
% The result h is 1 if the test rejects the null hypothesis at the 5
% significance level, and 0 otherwise.


[h,p,st] = chi2gof(pfeature,'Nbins', 20, 'Alpha',0.05)

% h =1, p = 0, It rejects the null hypothesis. 

%% Anderson-Darling test
% h = adtest(x) returns a test decision for the null hypothesis that the data
% in vector x is from a population with a normal distribution, using the
% Anderson-Darling test. The alternative hypothesis is that x is not from
% a population with a normal distribution. The result h is 1 if the test rejects
% the null hypothesis at the 5 significance level, or 0 otherwise

[h,p] = adtest(pfeature, 'Alpha', 0.05)

% h = 1, p =5e-4 , It rejects the null hypothesis. 

%% Jarque-Bera test
% h = jbtest(x) returns a test decision for the null hypothesis that the data
% in vector x comes from a normal distribution with an unknown mean and
% variance, using the Jarque-Bera test. The alternative hypothesis is that
% it does not come from such a distribution. The result h is 1 if the test
% rejects the null hypothesis at the 5 significance level, and 0 otherwise.

[h,p] = jbtest(pfeature)

% h = 1, p =1e-3 , It rejects the null hypothesis. 


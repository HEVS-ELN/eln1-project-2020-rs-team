close all;
clear;
path = '..\data\ConductiveProbe\';
freq = [];
V1=[];
V2=[];
for k=0:4
file = [path 'R10k_' num2str(k) '.csv'];
data = readmatrix(file, 'Range', 2);

freq(:,k+1) = data(:,1);
V2(:,k+1) = 10.^(data(:,3)/20).*exp(1j*data(:,4)*pi/180);
Amp2(:,k+1) = 10.^(data(:,3)/20);
Phase2(:,k+1) = data(:,4)*pi/180;

end


% ================= Known Variables ================= 
A=Amp2;
argH=Phase2;
R1 = 10e3;
w = freq*2*pi;
Rscope = 1e6;
Cscope = 24e-12;

% ================= Rpr and Cpr  ================= 
RInit=  (R1*A.*sqrt(1+(tan(argH)).^2))./(1- (A.*sqrt(1+(tan(argH)).^2)));
Rpr = (Rscope*RInit)./(Rscope-RInit);
Cpr= -1*(tan(argH).*(R1+Rpr))./(w*R1.*Rpr)-Cscope;

path1 = '..\data\';
fileRC = [path1 'Test-RprCpr.txt'];
opts = delimitedTextImportOptions('DataLines', 2,'VariableTypes','double','Delimiter','\t');
dataRC = readmatrix(fileRC,opts);

time = dataRC(:,1);
Vpulse = dataRC(:,2);
V01 = dataRC(:,3);
V02 = dataRC(:,4);
V03 = dataRC(:,5);
V04 = dataRC(:,6);
V05 = dataRC(:,7);

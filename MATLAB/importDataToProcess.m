fileData = ['..\data\Data.txt'];
probeNb = 5;
opts = delimitedTextImportOptions('DataLines', 2,'VariableTypes','double','Delimiter','\t');
dataP = readmatrix(fileData,opts);
t_in = dataP(:,1);
Vin = dataP(:,2);
Vout = [];
for i = 1:probeNb
    Vout = [Vout dataP(:,2+i)];
end
% Vout1 = dataP(:,3);
% Vout2 = dataP(:,4);
% Vout3 = dataP(:,5);
% Vout4 = dataP(:,6);
% Vout5 = dataP(:,7);
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

% ================= RPR AND CPR PLOTS ================= 
figure (1);
loglog(freq,Rpr);
legend('k0','k1','k2','k3','k4');
title('Rpr');
xlabel('frequency [Hz]');
ylabel('resistance [Ohms]');
figure (2);
loglog(freq,Cpr);
legend('k0','k1','k2','k3','k4');
title('Cpr');
xlabel('frequency [Hz]');
ylabel('capacitance [F]');





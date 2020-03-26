path = 'C:\Users\rashi\eln1-project-2020-rs-team\data\ConductiveProbe\';
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

A=Amp2;
argH=Phase2;
R1 = 10e3;
w = freq*2*pi;


Rpr=  (R1*A.*sqrt(1+(tan(argH)).^2))./(1- A.*sqrt(1+(tan(argH)).^2));
Cpr= (tan(argH).*(R1+Rpr))./(w*R1.*Rpr);

figure (1);
semilogx(freq,20*log10(abs(Rpr)));
legend('k0','k1','k2','k3','k4');
figure (2);
semilogx(freq,20*log10(abs(Cpr)));
legend('k0','k1','k2','k3','k4');

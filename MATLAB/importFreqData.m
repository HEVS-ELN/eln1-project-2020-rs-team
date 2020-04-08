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

% ================= Read LTspice sim ================= 
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

figure (3);
plot(time,[Vpulse V01 V02 V03 V04 V05]);
legend('Vpulse','V01','V02','V03','V04','V05');
title('Simulation Plot');
xlabel('time[ms]');
ylabel('voltage [V]');
ylim([-0.3 0.3]);

SampleFreq = 1e5; %the sample frequency for all the channels together
                 %how does "scan mode work??"

OutputSmpls = 2; %the number of output samples you will convert
                  %How much RAM does the processor have? How much
                  %of this can you use just for your signals?

Vmax = 3;        %the maximum voltage we can convert with the ADC

SignalFreq = 2e3;   %The frequency of your signal

%data(:,1) is the time vector exported from LTspice
%data(:,2) is one voltage channel measured
%data(:,3) is another voltage channel measured

%What does the following 5 lines do?

t0 = data(1,1)+rand(1)/SignalFreq;%décalage de temps pour éviter une synchro et on commence plus tard que 0
t1 = (t0:2/(SampleFreq):t0+(OutputSmpls-1)*2/(SampleFreq))';    %
t2 = t1+1/SampleFreq;                                           %
V1 = interp1(data(:,1), data(:,2), t1);                         %Valeur de y(t1)
V2 = interp1(data(:,1), data(:,3), t2);                         %Valeur de y(t2)

NoiseBits = 3;    %what are noise bits? Related to effective bits of the ADC

%What do these lines do?? What is randn() ?
V1dig=int16((2^15)*(V1/Vmax)+randn(OutputSmpls,1)*(2^NoiseBits));
V2dig=int16((2^15)*(V2/Vmax)+randn(OutputSmpls,1)*(2^NoiseBits));

%What do these lines do??
V1d=double(V1dig)*Vmax/(2^15);
V2d=double(V2dig)*Vmax/(2^15);

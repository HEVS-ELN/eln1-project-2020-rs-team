
figure;
tiledlayout(3,1);
nexttile;
plot(time,[Vpulse V01 V02 V03 V04 V05]);
legend('Vpulse','V01','V02','V03','V04','V05');
title('Simulation Plot');
xlabel('time[ms]');
ylabel('voltage [V]');
ylim([-0.3 0.3]);

SampleFreq = 1e4; %the sample frequency for all the channels together
                 %how does "scan mode work??"

OutputSmpls = 4000; %the number of output samples you will convert
                  %How much RAM does the processor have? How much
                  %of this can you use just for your signals?

Vmax = 1.5;        %the maximum voltage we can convert with the ADC
                    % Vbatt/2 = 1.65V > Vreal  

SignalFreq = 2e3;   %The frequency of our signal

%data(:,1) is the time vector exported from LTspice
%data(:,2) is one voltage channel measured
%data(:,3) is another voltage channel measured

t0 = dataRC(1,1)+rand(1)/SignalFreq;%décalage de temps pour éviter une synchro et on commence plus tard que 0
t1 = (t0:2/(SampleFreq):t0+(OutputSmpls-1)*2/(SampleFreq))';    %
t2 = t1+1/SampleFreq;                                           %
V1 = interp1(dataRC(:,1), dataRC(:,3), t1);                         %Valeur de y(t1)
V2 = interp1(dataRC(:,1), dataRC(:,4), t2);                         %Valeur de y(t2)

NoiseBits = 3;    %what are noise bits? Related to effective bits of the ADC

%What do these lines do?? What is randn() ? That's a random number around 
V1dig=int16((2^15)*(V1/Vmax)+randn(OutputSmpls,1)*(2^NoiseBits));
V2dig=int16((2^15)*(V2/Vmax)+randn(OutputSmpls,1)*(2^NoiseBits));

%What do these lines do??
V1d=double(V1dig)*Vmax/(2^15);%Double pour éviter le dépassement de capacité sur MATLAB
V2d=double(V2dig)*Vmax/(2^15);

nexttile;
plot([dataRC(:,1) dataRC(:,1)], [dataRC(:,3) dataRC(:,4)]);

nexttile;
plot([t1 t2], [V1d V2d],'-x');

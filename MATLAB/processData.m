
sampleFreq = 1e5;
sampleNb = 4000;
samplingTime = sampleNb/sampleFreq;
Vmax = 1.5;
signalFreq = 2e3;
noiseBits = 3;
probeNb = 5;

t0 = t_in+rand(1)/signalFreq;
t1 = (t0:2/(sampleFreq):t0+(sampleNb-1)*2/(sampleFreq))';
t2 = t1+1/sampleFreq;

Vin_sampled = interp1(t_in, Vin, t1);
Vin_dig=int16((2^15)*(Vin_sampled/Vmax)+randn(sampleNb,1)*(2^noiseBits));
Vin_d=double(Vin_dig)*Vmax/(2^15);

Vout_sampled = [];
Vout_dig = [];
Vout_d = [];

for i = 1:probeNb
Vout_sampled = [Vout_sampled interp1(t_in, Vout(:,i), t2)];
Vout_dig = [Vout_dig int16((2^15)*(Vout_sampled(:,i)/Vmax)+randn(sampleNb,1)*(2^noiseBits))];
Vout_d = [Vout_d double(Vout_dig(:,i))*Vmax/(2^15)];
end

% plot([t1 t2 t2], [Vin_d Vout1_d Vout2_d],'-x');

test = [];
for i = 1:probeNb
   test = [test process(Vin_d, Vout_d(:,i))];
end

testOut = [];
for i = 1:probeNb
   testOut = [testOut floor(test(:,i))]; 
end

figure; imagesc(testOut); colormap(jet(10)); colorbar;
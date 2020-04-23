
% ================= RPR AND CPR PLOTS ================= 
figure;
tiledlayout(2,1);
nexttile;
loglog(freq,Rpr);
legend('k0','k1','k2','k3','k4');
title('Rpr');
xlabel('frequency [Hz]');
ylabel('resistance [Ohms]');

nexttile;
loglog(freq,Cpr);
legend('k0','k1','k2','k3','k4');
title('Cpr');
xlabel('frequency [Hz]');
ylabel('capacitance [F]');
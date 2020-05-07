function [out] = process(Vref,Vmeas)
Vref = abs(Vref);
Vmeas = abs(Vmeas);

Mref = mean(Vref);
Mmeas = mean(Vmeas);

rawOut = Mmeas / Mref;
ratio = 6;

out = rawOut *ratio;
end


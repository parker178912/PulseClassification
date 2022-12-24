% Returns the Tp of the first potential pulse which is classified as
% pulse-like . Returns -999 if the ground motion is not pulse-like

function Tp = find_Tp(pulseData)

Tp = -999;
buff = pulseData;
if(buff.is_pulse == 1)
    Tp = buff.Tp;
    return;
end

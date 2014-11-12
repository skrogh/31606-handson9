function [h] = equalizer5band(G1, G2, G3, G4, G5, n, W);
%INPUT: Five band gains: G1, G2, G3, G4, G5. Approximate length: n. Window type: W.
%OUTPUT: Impulse response/FIR filter coefficients: h.
m = round(n/10);
H = [G1*ones(1, m) , G2*ones(1, m) , ...
     G3*ones(1, m) , G4*ones(1, m) , ...
     G5*ones(1, m) , G5*ones(1, m) , ...
     G4*ones(1, m) , G3*ones(1, m) , ...
     G2*ones(1, m) , G1*ones(1, m)];
h = ifftshift(ifft(H, 'symmetric'));
L = length(h);
if W == 0 %really unnecessary
   h = h; %do nothing
elseif W == 1
   h = h.*hanning(L)';
elseif W == 2
   h =h.*hamming(L)'; 
end
end %eof


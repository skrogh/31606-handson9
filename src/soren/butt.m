function Hd = butt
%ELLIPT Returns a discrete-time filter object.

%
% MATLAB Code
% Generated by MATLAB(R) 8.0 and the Signal Processing Toolbox 6.18.
%
% Generated on: 09-Nov-2014 14:03:04
%

% Elliptic Bandpass filter designed using FDESIGN.BANDPASS.

% All frequency values are normalized to 1.

Fstop1 = 0.1;     % First Stopband Frequency
Fpass1 = 0.2;     % First Passband Frequency
Fpass2 = 0.3;     % Second Passband Frequency
Fstop2 = 0.4;     % Second Stopband Frequency
Astop1 = 100;     % First Stopband Attenuation (dB)
Apass  = 2;       % Passband Ripple (dB)
Astop2 = 100;     % Second Stopband Attenuation (dB)
match  = 'pass';  % Band to match exactly

% Construct an FDESIGN object and call its ELLIP method.
h  = fdesign.bandpass(Fstop1, Fpass1, Fpass2, Fstop2, Astop1, Apass, ...
                      Astop2);
Hd = design(h, 'butter', 'MatchExactly', match);

% [EOF]


